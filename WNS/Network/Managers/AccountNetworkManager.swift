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

// Member
final class AccountNetworkManager {
    
    static let shared = AccountNetworkManager()
    private init() { }
    
    func join(body: JoinBody, handler: @escaping ((JoinResponse) -> Void)) {
        do {
            let request = try Router.join(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: JoinResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("에러코드: \(statusCode) 필수값을 채워주세요")
                            case 409:
                                print("에러코드: \(statusCode) 이미 가입된 유저입니다")
                            default:
                                print("Unknown Error: \(failure)")
                            }
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func emailDuplicateCheck(body: EmailDuplicationCheckBody,
                             handler: @escaping ((EmailDuplicateCheckResponse) -> Void),
                             onResponseError: @escaping ((String) -> Void)) {
        do {
            let request = try Router.emailDuplicateCheck(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EmailDuplicateCheckResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                onResponseError("필수값을 채워주세요")
                            case 409:
                                onResponseError("이미 사용중인 이메일입니다")
                            default:
                                print("Failed")
                                onResponseError(failure.localizedDescription)
                            }
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func login(body: LoginBody,
               handler: @escaping ((LoginResponse) -> Void),
               onResponseError: @escaping ((String) -> Void)) {
        do {
            let request = try Router.login(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: LoginResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        AccountManager.shared.setWtihResponse(body: body, response: response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("에러코드: \(statusCode) 필수값을 채워주세요")
                                onResponseError("필수값을 채워주세요")
                            case 401:
                                print("에러코드: \(statusCode) 계정을 확인해주세요")
                                onResponseError("계정을 확인해주세요")
                            default:
                                print("Failed: \(failure)")
                                onResponseError("failure")
                            }
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func refreshAccessToken(handler: @escaping (() -> Void), onFail: @escaping ((String) -> Void)) {
        do {
            let request = try Router.refreshAccessToken.asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: RefreshResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        AccountManager.shared.access = response.accessToken
                        print("액세스 토큰 업데이트 완료")
                        handler()
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                onFail("인증할 수 없는 액세스/리프레시 토큰입니다")
                                print("인증할 수 없는 액세스/리프레시 토큰입니다")
                            case 403:
                                onFail("Forbidden \(#function)")
                                print("Forbidden \(#function)")
                            case 418:
                                onFail("리프레시 토큰이 만료되었습니다. 다시 로그인 해주세요")
                                print("리프레시 토큰이 만료되었습니다. 다시 로그인 해주세요")
                            default:
                                print("Failed: \(failure)")
                            }
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func withdraw(handler: @escaping ((WithdrawResponse) -> Void)) {
        do {
            let request = try Router.withdraw.asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: WithdrawResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 419:
                                print("액세스 토큰이 만료되었습니다. 다시 로그인 해주세요")
                                self.refreshAccessToken {
                                    self.withdraw { _ in }
                                } onFail: { message in
                                    
                                }
                                
                            default:
                                print("Failed: \(failure)")
                            }
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
}
