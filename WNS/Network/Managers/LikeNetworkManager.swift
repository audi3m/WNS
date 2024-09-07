//
//  LikeNetworkManager.swift
//  WNS
//
//  Created by J Oh on 9/7/24.
//

import Foundation
import Alamofire

// Like
final class LikeNetworkManager {
    
    static let shared = LikeNetworkManager()
    private init() { }
    
    func like(postID: String, body: LikeBody, handler: @escaping ((LikeResponse) -> Void)) {
        do {
            let request = try Router.likePost(postID: postID, body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: LikeResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청입니다")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 410:
                                print("게시글을 찾을 수 없습니다")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
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
    
    func like2(postID: String, body: LikeBody, handler: @escaping ((Like2Response) -> Void)) {
        do {
            let request = try Router.like2Post(postID: postID, body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Like2Response.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청입니다")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 410:
                                print("게시글을 찾을 수 없습니다")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
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
    
    func getLikePosts(query: GetLikePostQuery, handler: @escaping ((LikePostResponse) -> Void)) {
        do {
            let request = try Router.getLikePost(query: query).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: LikePostResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청입니다")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
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
    
    func getLike2Posts(query: GetLikePostQuery, handler: @escaping ((Like2PostResponse) -> Void)) {
        do {
            let request = try Router.getLike2Post(query: query).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Like2PostResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청입니다")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
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
    
    func follow(userID: String, handler: @escaping ((FollowResponse) -> Void)) {
        do {
            let request = try Router.follow(userID: userID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: FollowResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청입니다")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 409:
                                print("이미 팔로우 중인 계정입니다")
                            case 410:
                                print("알 수 없는 계정입니다")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
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
    
    func unFollow(userID: String, handler: @escaping ((UnFollowResponse) -> Void)) {
        do {
            let request = try Router.unfollow(userID: userID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: UnFollowResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청입니다")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 410:
                                print("알 수 없는 계정입니다")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
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
