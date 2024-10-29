//
//  AccountNetworkManager.swift
//  WNS
//
//  Created by J Oh on 9/7/24.
//

import Foundation
import Alamofire

enum RequestError: Error {
    case invalidURL
}

enum AccountError: Error {
    case requiredError // 400
    case checkAccount // 401
    case tokenUnavailable // 401
    case nicknameSpace // 402
    case forbidden // 403
    case userAlreadyExists // 409
    case refreshTokenExpired // 418
    case accessTokenExpired // 419
    case unknown
    case statusCodeError
}

// Member
final class AccountNetworkManager {
    
    static let shared = AccountNetworkManager()
    private init() { }
    
    func join(body: JoinBody, handler: @escaping (Result<JoinResponse, AccountError>) -> Void) {
        do {
            let request = try Router.join(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: JoinResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("에러코드: \(statusCode) 필수값을 채워주세요")
                                handler(.failure(.requiredError))
                            case 402:
                                print("에러코드: \(statusCode) 공백이 포함된 닉네임은 사용할 수 없습니다")
                                handler(.failure(.nicknameSpace))
                            case 409:
                                print("에러코드: \(statusCode) 이미 가입된 유저입니다")
                                handler(.failure(.userAlreadyExists))
                            default:
                                print("Failed: \(failure)")
                                handler(.failure(.unknown))
                            }
                        } else {
                            print("Status Code Error")
                            handler(.failure(.statusCodeError))
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func emailDuplicateCheck(body: EmailDuplicationCheckBody, handler: @escaping (Result<EmailDuplicateCheckResponse, AccountError>) -> Void) {
        do {
            let request = try Router.emailDuplicateCheck(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EmailDuplicateCheckResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("에러코드: \(statusCode) 필수값을 채워주세요")
                                handler(.failure(.requiredError))
                            case 409:
                                print("에러코드: \(statusCode) 이미 가입된 유저입니다")
                                handler(.failure(.userAlreadyExists))
                            default:
                                print("Failed: \(failure)")
                                handler(.failure(.unknown))
                            }
                        } else {
                            print("Status Code Error")
                            handler(.failure(.statusCodeError))
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func login(body: LoginBody, handler: @escaping (Result<LoginResponse, AccountError>) -> Void) {
        do {
            let request = try Router.login(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: LoginResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                        AccountManager.shared.access = response.accessToken
                        AccountManager.shared.refresh = response.refreshToken
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("에러코드: \(statusCode) 필수값을 채워주세요")
                                handler(.failure(.requiredError))
                            case 401:
                                print("에러코드: \(statusCode) 계정을 확인하세요")
                                handler(.failure(.checkAccount))
                            default:
                                print("Failed: \(failure)")
                                handler(.failure(.unknown))
                            }
                        } else {
                            print("Status Code Error")
                            handler(.failure(.statusCodeError))
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func refreshAccessToken(handler: @escaping (Result<(), AccountError>) -> Void) {
        do {
            let request = try Router.refreshAccessToken.asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: RefreshResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        AccountManager.shared.access = response.accessToken
                        print("액세스 토큰 업데이트 완료")
                        handler(.success(()))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스/리프레시 토큰입니다")
                                handler(.failure(.tokenUnavailable))
                            case 403:
                                print("Forbidden \(#function)")
                                handler(.failure(.forbidden))
                            case 418:
                                print("리프레시 토큰이 만료되었습니다. 다시 로그인 해주세요")
                                handler(.failure(.refreshTokenExpired))
                            default:
                                print("Failed: \(failure)")
                                handler(.failure(.unknown))
                            }
                        } else {
                            print("Status Code Error")
                            handler(.failure(.statusCodeError))
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func withdraw(handler: @escaping (Result<WithdrawResponse, AccountError>) -> Void) {
        do {
            let request = try Router.withdraw.asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: WithdrawResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스/리프레시 토큰입니다")
                                handler(.failure(.tokenUnavailable))
                            case 403:
                                print("Forbidden")
                                handler(.failure(.forbidden))
                            case 419:
                                print("액세스 토큰이 만료되었습니다. 다시 로그인 해주세요")
                                handler(.failure(.accessTokenExpired))
                            default:
                                print("Failed: \(failure)")
                                handler(.failure(.unknown))
                            }
                        } else {
                            print("Status Code Error")
                            handler(.failure(.statusCodeError))
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
}
