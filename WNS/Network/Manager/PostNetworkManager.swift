//
//  PostNetworkManager.swift
//  WNS
//
//  Created by J Oh on 9/7/24.
//

import Foundation
import Alamofire

enum PostError: Error {
    case wrongRequest // 400
    case requiredError // 400
    case typeError // 400
    case tokenUnavailable // 401
    case forbidden // 403
    case serverError // 410
    case postNotFound // 410
    case noPermission // 445
    case accessTokenExpired // 419
    case unknown
    case statusCodeError
}

// Post
final class PostNetworkManager {
    
    static let shared = PostNetworkManager()
    private init() { }
    
    func postImages(items: [ImageItem], handler: @escaping (Result<PostImageResponse, PostError>) -> Void) {
        guard !items.isEmpty else {
            handler(.success(PostImageResponse(files: [])))
            return
        }
        let url = APIKey.baseURL + "v1/posts/files"
        let headers: HTTPHeaders = [
            Header.contentType: HeaderValue.multipart.rawValue,
            Header.sesacKey: APIKey.key
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for item in items {
                if let data = item.image.jpegData(compressionQuality: 0.1) {
                    multipartFormData.append(data, withName: "files", fileName: item.id, mimeType: "image/jpeg")
                }
            }
        },
                  to: url, headers: headers, interceptor: TokenInterceptor.shared)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: PostImageResponse.self) { response in
            switch response.result {
            case .success(let response):
                handler(.success(response))
            case .failure(let failure):
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 400:
                        print("잘못된 요청입니다/필수값을 채워주세요/파일 용량")
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
    }
    
    func writePost(body: PostBody, handler: @escaping (Result<Post, PostError>) -> Void) {
        do {
            let request = try Router.writePost(body: body).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Post.self) { response in
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
                            case 410:
                                print("생성된 게시글이 없습니다. 서버장애")
                                handler(.failure(.serverError))
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
    
    func getImages(dir: String, handler: @escaping (Result<Post, PostError>) -> Void) {
        do {
            let request = try Router.getImages(dir: dir).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Post.self) { response in
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
                            case 410:
                                print("생성된 게시글이 없습니다. 서버장애")
                                handler(.failure(.serverError))
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
    
    func getAllPosts(query: GetAllPostQuery, handler: @escaping (Result<GetAllPostsResponse, PostError>) -> Void) {
        do {
            let request = try Router.getAllPosts(query: query).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetAllPostsResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청")
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
    
    func getSomePost(postID: String, handler: @escaping (Result<Post, PostError>) -> Void) {
        do {
            let request = try Router.getSomePost(postID: postID).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Post.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청")
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
    
    func editPost(postID: String, body: PostBody, handler: @escaping (Result<EditPostResponse, PostError>) -> Void) {
        do {
            let request = try Router.editPost(postID: postID, body: body).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EditPostResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("유효하지 않은 값 타입입니다")
                                handler(.failure(.typeError))
                            case 401:
                                print("인증할 수 없는 액세스/리프레시 토큰입니다")
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
                                print("게시글 수정 권한이 없습니다")
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
    
    func deletePost(postID: String, handler: @escaping (Result<(), PostError>) -> Void) {
        do {
            let request = try Router.deletePost(postID: postID).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .response { response in
                    switch response.result {
                    case .success:
                        handler(.success(()))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스/리프레시 토큰입니다")
                                handler(.failure(.tokenUnavailable))
                            case 403:
                                print("Forbidden")
                                handler(.failure(.forbidden))
                            case 410:
                                print("삭제할 게시글을 찾을 수 없습니다")
                                handler(.failure(.postNotFound))
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                                handler(.failure(.accessTokenExpired))
                            case 445:
                                print("게시글 삭제 권한이 없습니다")
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
    
    func getUserPosts(userID: String, query: GetAllPostQuery, handler: @escaping (Result<GetUserPostResponse, PostError>) -> Void) {
        do {
            let request = try Router.getUserPost(userID: userID, query: query).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetUserPostResponse.self) { response in
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
