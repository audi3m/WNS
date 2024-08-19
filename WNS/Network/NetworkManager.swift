//
//  NetworkManager.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
}

extension NetworkManager {
    func handleCommonResponseCode(code: Int) {
        
    }
}

// Member
extension NetworkManager {
    
    func join(body: JoinBody) {
        do {
            let request = try Router.join(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: JoinResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
                             handler: @escaping (String) -> Void,
                             onError: @escaping (String) -> Void) {
        do {
            let request = try Router.emailDuplicateCheck(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EmailDuplicateCheckResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response.message)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("필수값을 채워주세요")
                            case 409:
                                print("이미 사용중인 이메일입니다")
                                onError("이미 사용중인 이메일입니다")
                            default:
                                print("Failed")
                                print(failure)
                            }
                        }
                    }
            }
            
        } catch {
            print(error)
        }
    }
    
    func login(body: LoginBody, handler: @escaping (LoginResponse) -> Void, failHandler: @escaping (String) -> Void) {
        do {
            let request = try Router.login(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: LoginResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("에러코드: \(statusCode) 필수값을 채워주세요")
                                failHandler("에러코드: \(statusCode) 필수값을 채워주세요")
                            case 401:
                                print("에러코드: \(statusCode) 계정을 확인해주세요")
                                failHandler("에러코드: \(statusCode) 계정을 확인해주세요")
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
    
    func refreshAccessToken() {
        
        do {
            let request = try Router.refreshAccessToken.asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: RefreshResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스/리프레시 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 418:
                                print("리프레시 토큰이 만료되었습니다. 다시 로그인 해주세요")
                                // 로그인 화면 전환
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
    
    func withdraw() {
        do {
            let request = try Router.withdraw.asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: WithdrawResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 419:
                                print("액세스 토큰이 만료되었습니다. 다시 로그인 해주세요")
                                self.refreshAccessToken()
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
extension NetworkManager {
    
    func postImage(body: PostImageBody) {
        do {
            let request = try Router.postImage(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: PostImageResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청입니다\n필수값을 채워주세요")
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
    
    func writePost(body: PostBody) {
        do {
            let request = try Router.writePost(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: PostResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func getAllPosts(query: GetAllPostQuery) {
        do {
            let request = try Router.getAllPosts(query: query).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetAllPostsResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func getSomePost(postID: String) {
        do {
            let request = try Router.getSomePost(postID: postID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetSomePostResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func editPost(postID: String, body: PostBody) {
        do {
            let request = try Router.editPost(postID: postID, body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EditPostResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func deletePost(postID: String) {
        do {
            let request = try Router.deletePost(postID: postID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .response { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func getUserPost(userID: String, query: GetAllPostQuery) {
        do {
            let request = try Router.getUserPost(userID: userID, query: query).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetUserPostResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
extension NetworkManager {
    
    func writeComment(postID: String, body: CommentBody) {
        do {
            let request = try Router.writeComments(postID: postID, body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: WriteCommentResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func editComment(postID: String, commentID: String, body: CommentBody) {
        do {
            let request = try Router.editComments(postID: postID, commentID: commentID, body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EditCommentResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func deleteComment(postID: String, commentID: String) {
        do {
            let request = try Router.deleteComments(postID: postID, commentID: commentID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .response { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
extension NetworkManager {
    
    func like(postID: String, body: LikeBody) {
        do {
            let request = try Router.likePost(postID: postID, body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: LikeResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func like2(postID: String, body: LikeBody) {
        do {
            let request = try Router.like2Post(postID: postID, body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Like2Response.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func getLikePosts(query: GetLikePostQuery) {
        do {
            let request = try Router.getLikePost(query: query).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: LikePostResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func getLike2Posts(query: GetLikePostQuery) {
        do {
            let request = try Router.getLike2Post(query: query).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: Like2PostResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func follow(userID: String) {
        do {
            let request = try Router.follow(userID: userID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: FollowResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func unFollow(userID: String) {
        do {
            let request = try Router.unfollow(userID: userID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: UnFollowResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
extension NetworkManager {
    
    func getMyProfile() {
        do {
            let request = try Router.getMyProfile.asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetMyProfileResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func editMyProfile(body: ProfileBody) {
        do {
            let request = try Router.editMyProfile(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EditMyProfileResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
    
    func getOthersProfile(userID: String) {
        do {
            let request = try Router.getOthersProfile(userID: userID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetOthersProfileResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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

// Hashtag
extension NetworkManager {
    
    func searchHashtag(query: HashQuery) {
        do {
            let request = try Router.searchHash(query: query).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: HashtagResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
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
