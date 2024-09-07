//
//  NetworkManager.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation
import Alamofire

enum RequestError: Error {
    case invalidURL
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func request() {
        
    }
    
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

// Comment
final class CommentsNetworkManager {
    
    static let shared = CommentsNetworkManager()
    private init() { }
    
    func writeComment(postID: String, body: CommentBody, handler: @escaping ((WriteCommentResponse) -> Void)) {
        do {
            let request = try Router.writeComments(postID: postID, body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: WriteCommentResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("필수값이 누락되었습니다")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 410:
                                print("댓글을 추가할 게시글을 찾을 수 없습니다\n댓글생성 실패")
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
    
    func editComment(postID: String, commentID: String, body: CommentBody, handler: @escaping ((EditCommentResponse) -> Void)) {
        do {
            let request = try Router.editComments(postID: postID, commentID: commentID, body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EditCommentResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("필수값이 누락되었습니다")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 410:
                                print("수정할 게시글을 찾을 수 없습니다")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                            case 445:
                                print("댓글 수정 권한이 없습니다")
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
    
    func deleteComment(postID: String, commentID: String, handler: @escaping (() -> Void)) {
        do {
            let request = try Router.deleteComments(postID: postID, commentID: commentID).asURLRequest()
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
                                print("삭제할 댓글을 찾을 수 없습니다")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                            case 445:
                                print("댓글 삭제 권한이 없습니다")
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

// Profile
final class ProfileNetworkManager {
    
    static let shared = ProfileNetworkManager()
    private init() { }
    
    func getMyProfile(handler: @escaping ((GetMyProfileResponse) -> Void)) {
        do {
            let request = try Router.getMyProfile.asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetMyProfileResponse.self) { response in
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
    
    func editMyProfile(body: ProfileBody, handler: @escaping ((EditMyProfileResponse) -> Void)) {
        do {
            let request = try Router.editMyProfile(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EditMyProfileResponse.self) { response in
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
    
    func getOthersProfile(userID: String, handler: @escaping ((GetOthersProfileResponse) -> Void)) {
        do {
            let request = try Router.getOthersProfile(userID: userID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetOthersProfileResponse.self) { response in
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

// Search
final class SearchNetworkManager {
    
    static let shared = SearchNetworkManager()
    private init() { }
    
    func searchUsers(query: SearchUserQuery, handler: @escaping ((SearchUsersResponse) -> Void)) {
        do {
            let request = try Router.searchUser(query: query).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: SearchUsersResponse.self) { response in
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
    
    func searchHashtag(query: HashQuery, handler: @escaping ((HashtagResponse) -> Void)) {
        do {
            let request = try Router.searchHash(query: query).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: HashtagResponse.self) { response in
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
