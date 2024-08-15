//
//  GetOthersProfileResponse.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct GetOthersProfileResponse: Decodable {
    let userID: String
    let nick: String
    let profileImage: String?
    let followers: [Profile]
    let following: [Profile]
    let posts: [String]
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nick
        case profileImage
        case followers
        case following
        case posts
    }
}
