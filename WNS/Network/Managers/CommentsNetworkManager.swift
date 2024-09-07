//
//  CommentsNetworkManager.swift
//  WNS
//
//  Created by J Oh on 9/7/24.
//

import Foundation
import Alamofire

enum CommentsError: Error {
    case requiredError // 400
    case tokenUnavailable // 401
    case forbidden // 403
    case postNotFound // 410
    case accessTokenExpired // 419
    case noPermission // 445
    case unknown
    case statusCodeError
}

// Comment
final class CommentsNetworkManager {
    
    static let shared = CommentsNetworkManager()
    private init() { }
    
    func writeComment(postID: String, body: CommentBody, handler: @escaping (Result<WriteCommentResponse, CommentsError>) -> Void) {
        do {
            let request = try Router.writeComments(postID: postID, body: body).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: WriteCommentResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("필수값이 누락되었습니다")
                                handler(.failure(.requiredError))
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                                handler(.failure(.tokenUnavailable))
                            case 403:
                                print("Forbidden")
                                handler(.failure(.forbidden))
                            case 410:
                                print("댓글을 추가할 게시글을 찾을 수 없습니다\n댓글생성 실패")
                                handler(.failure(.postNotFound))
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
    
    func editComment(postID: String, commentID: String, body: CommentBody, handler: @escaping (Result<EditCommentResponse, CommentsError>) -> Void) {
        do {
            let request = try Router.editComments(postID: postID, commentID: commentID, body: body).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EditCommentResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("필수값이 누락되었습니다")
                                handler(.failure(.requiredError))
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                                handler(.failure(.tokenUnavailable))
                            case 403:
                                print("Forbidden")
                                handler(.failure(.forbidden))
                            case 410:
                                print("수정할 게시글을 찾을 수 없습니다")
                                handler(.failure(.postNotFound))
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                                handler(.failure(.accessTokenExpired))
                            case 445:
                                print("댓글 수정 권한이 없습니다")
                                handler(.failure(.noPermission))
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
    
    func deleteComment(postID: String, commentID: String, handler: @escaping (Result<(), CommentsError>) -> Void) {
        do {
            let request = try Router.deleteComments(postID: postID, commentID: commentID).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .response { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(()))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                                handler(.failure(.tokenUnavailable))
                            case 403:
                                print("Forbidden")
                                handler(.failure(.forbidden))
                            case 410:
                                print("삭제할 댓글을 찾을 수 없습니다")
                                handler(.failure(.postNotFound))
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                                handler(.failure(.accessTokenExpired))
                            case 445:
                                print("댓글 삭제 권한이 없습니다")
                                handler(.failure(.noPermission))
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
