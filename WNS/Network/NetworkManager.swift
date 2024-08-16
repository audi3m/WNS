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

// Member
extension NetworkManager {
    
    func join(body: JoinBody) {
        do {
            let request = try Router.join(body: body).asURLRequest()
            AF.request(request).responseDecodable(of: JoinResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func emailValidation(body: EmailValidationBody) {
        do {
            let request = try Router.emailValidation(body: body).asURLRequest()
            AF.request(request).responseDecodable(of: EmailValidationResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func login(body: LoginBody) {
        do {
            let request = try Router.login(body: body).asURLRequest()
            AF.request(request).responseDecodable(of: LoginResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func refreshAccessToken() {
        
        do {
            let request = try Router.refreshAccessToken.asURLRequest()
            AF.request(request).responseDecodable(of: RefreshResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func withdraw() {
        do {
            let request = try Router.withdraw.asURLRequest()
            AF.request(request).responseDecodable(of: WithdrawResponse.self) { response in
                
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
            AF.request(request).responseDecodable(of: PostImageResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }

    }
    
    func writePost(body: PostBody) {
        do {
            let request = try Router.writePost(body: body).asURLRequest()
            AF.request(request).responseDecodable(of: PostResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func getAllPosts(query: GetAllPostQuery) {
        do {
            let request = try Router.getAllPosts(query: query).asURLRequest()
            AF.request(request).responseDecodable(of: GetAllPostsResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func getSomePost(postID: String) {
        do {
            let request = try Router.getSomePost(postID: postID).asURLRequest()
            AF.request(request).responseDecodable(of: GetSomePostResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func editPost(postID: String, body: PostBody) {
        do {
            let request = try Router.editPost(postID: postID, body: body).asURLRequest()
            AF.request(request).responseDecodable(of: EditPostResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func deletePost(postID: String) {
        do {
            let request = try Router.deletePost(postID: postID).asURLRequest()
            AF.request(request).response { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func getUserPost(userID: String, query: GetAllPostQuery) {
        do {
            let request = try Router.getUserPost(userID: userID, query: query).asURLRequest()
            AF.request(request).responseDecodable(of: GetUserPostResponse.self) { response in
                
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
            AF.request(request).responseDecodable(of: WriteCommentResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func editComment(postID: String, commentID: String, body: CommentBody) {
        do {
            let request = try Router.editComments(postID: postID, commentID: commentID, body: body).asURLRequest()
            AF.request(request).responseDecodable(of: EditCommentResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func deleteComment(postID: String, commentID: String) {
        do {
            let request = try Router.deleteComments(postID: postID, commentID: commentID).asURLRequest()
            AF.request(request).response { response in
                
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
            AF.request(request).responseDecodable(of: LikeResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func like2(postID: String, body: LikeBody) {
        do {
            let request = try Router.like2Post(postID: postID, body: body).asURLRequest()
            AF.request(request).responseDecodable(of: Like2Response.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func getLikePosts(query: GetLikePostQuery) {
        do {
            let request = try Router.getLikePost(query: query).asURLRequest()
            AF.request(request).responseDecodable(of: LikePostResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func getLike2Posts(query: GetLikePostQuery) {
        do {
            let request = try Router.getLike2Post(query: query).asURLRequest()
            AF.request(request).responseDecodable(of: Like2PostResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func follow(userID: String) {
        do {
            let request = try Router.follow(userID: userID).asURLRequest()
            AF.request(request).responseDecodable(of: FollowResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func unFollow(userID: String) {
        do {
            let request = try Router.unfollow(userID: userID).asURLRequest()
            AF.request(request).responseDecodable(of: UnFollowResponse.self) { response in
                
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
            AF.request(request).responseDecodable(of: GetMyProfileResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func editMyProfile(body: ProfileBody) {
        do {
            let request = try Router.editMyProfile(body: body).asURLRequest()
            AF.request(request).responseDecodable(of: EditMyProfileResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
    
    func getOthersProfile(userID: String) {
        do {
            let request = try Router.getOthersProfile(userID: userID).asURLRequest()
            AF.request(request).responseDecodable(of: GetOthersProfileResponse.self) { response in
                
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
            AF.request(request).responseDecodable(of: HashtagResponse.self) { response in
                
            }
            
        } catch {
            print(error)
        }
    }
}
