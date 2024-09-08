//
//  ProfileNetworkManager.swift
//  WNS
//
//  Created by J Oh on 9/7/24.
//

import Foundation
import Alamofire

enum ProfileError: Error {
    case wrongRequest // 400
    case tokenUnavailable // 401
    case forbidden // 403
    case accessTokenExpired // 419
    case unknown
    case statusCodeError
}

// Profile
final class ProfileNetworkManager {
    
    static let shared = ProfileNetworkManager()
    private init() { }
    
    func getMyProfile(handler: @escaping (Result<GetMyProfileResponse, ProfileError>) -> Void) {
        do {
            let request = try Router.getMyProfile.asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetMyProfileResponse.self) { response in
                    switch response.result {
                    case .success(let response):
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
                                print("액세스 토큰이 만료되었습니다")
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
    
    func editMyProfile(body: ProfileBody, handler: @escaping (Result<EditMyProfileResponse, ProfileError>) -> Void) {
        do {
            let request = try Router.editMyProfile(body: body).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EditMyProfileResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청입니다")
                                handler(.failure(.wrongRequest))
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                                handler(.failure(.tokenUnavailable))
                            case 403:
                                print("Forbidden")
                                handler(.failure(.forbidden))
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
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
    
    func getOthersProfile(userID: String, handler: @escaping (Result<GetOthersProfileResponse, ProfileError>) -> Void) {
        do {
            let request = try Router.getOthersProfile(userID: userID).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetOthersProfileResponse.self) { response in
                    switch response.result {
                    case .success(let response):
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
                                print("액세스 토큰이 만료되었습니다")
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
