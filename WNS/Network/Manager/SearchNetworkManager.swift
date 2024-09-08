//
//  NetworkManager.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation
import Alamofire

enum SearchError: Error {
    case wrongRequest // 400
    case tokenUnavailable // 401
    case forbidden // 403
    case accessTokenExpired // 419
    case unknown
    case statusCodeError
}

// Search
final class SearchNetworkManager {
    
    static let shared = SearchNetworkManager()
    private init() { }
    
    func searchUsers(query: SearchUserQuery, handler: @escaping (Result<SearchUsersResponse, SearchError>) -> Void) {
        do {
            let request = try Router.searchUser(query: query).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: SearchUsersResponse.self) { response in
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
    
    func searchHashtag(query: HashQuery, handler: @escaping (Result<HashtagResponse, SearchError>) -> Void) {
        do {
            let request = try Router.searchHash(query: query).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: HashtagResponse.self) { response in
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
