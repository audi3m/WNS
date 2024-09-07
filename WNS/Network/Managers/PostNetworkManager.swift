//
//  PostNetworkManager.swift
//  WNS
//
//  Created by J Oh on 9/7/24.
//

import Foundation
import Alamofire

// Post
final class PostNetworkManager {
    
    static let shared = PostNetworkManager()
    private init() { }
    
    func postImages(items: [ImageItem], handler: @escaping ((PostImageResponse) -> Void)) {
        guard !items.isEmpty else {
            handler(PostImageResponse(files: []))
            return
        }
        let url = APIKey.baseURL + "v1/posts/files"
        let headers: HTTPHeaders = [
            Header.authorization: AccountManager.shared.access,
            Header.contentType: HeaderValue.multipart.rawValue,
            Header.sesacKey: APIKey.key
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for item in items {
                if let data = item.image.jpegData(compressionQuality: 0.1) {
                    multipartFormData.append(data, withName: "files", fileName: item.id, mimeType: "image/jpeg")
                }
            }
        }, to: url, headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: PostImageResponse.self) { response in
            switch response.result {
            case .success(let success):
                dump(success.files)
                handler(success)
                print("이미지 업로드 완료")
            case .failure(let failure):
                if response.response?.statusCode == 419 {
                    // 토큰 갱신
                    print(failure)
                    
                }
            }
        }
    }
    
    func writePost(body: PostBody, handler: @escaping ((Post) -> Void)) {
        do {
            let request = try Router.writePost(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Post.self) { response in
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
                            case 410:
                                print("생성된 게시글이 없습니다. 서버장애")
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
    
    func getImages(dir: String, handler: @escaping ((Post) -> Void)) {
        do {
            let request = try Router.getImages(dir: dir).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Post.self) { response in
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
                            case 410:
                                print("생성된 게시글이 없습니다. 서버장애")
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
    
    func getAllPosts(query: GetAllPostQuery, handler: @escaping ((GetAllPostsResponse) -> Void)) {
        do {
            let request = try Router.getAllPosts(query: query).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetAllPostsResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다 - getAllPosts")
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
    
    func getSomePost(postID: String, handler: @escaping ((Post) -> Void)) {
        do {
            let request = try Router.getSomePost(postID: postID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Post.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청")
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
    
    func editPost(postID: String, body: PostBody, handler: @escaping ((EditPostResponse) -> Void)) {
        do {
            let request = try Router.editPost(postID: postID, body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EditPostResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("필수값을 채워주세요")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 410:
                                print("수정할 게시글을 찾을 수 없습니다")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                            case 445:
                                print("게시글 수정 권한이 없습니다")
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
    
    func deletePost(postID: String, handler: @escaping (() -> Void)) {
        do {
            let request = try Router.deletePost(postID: postID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .response { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler()
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 410:
                                print("삭제할 게시글을 찾을 수 없습니다")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                            case 445:
                                print("게시글 삭제 권한이 없습니다")
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
    
    func getUserPosts(userID: String, query: GetAllPostQuery, handler: @escaping ((GetUserPostResponse) -> Void)) {
        do {
            let request = try Router.getUserPost(userID: userID, query: query).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetUserPostResponse.self) { response in
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
    
}
