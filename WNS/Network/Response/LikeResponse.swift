//
//  LikeResponse.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct LikeResponse: Decodable {
    let likeStatus: Bool
    
    enum CodingKeys: String, CodingKey {
        case likeStatus = "like_status"
    }
}

struct Like2Response: Decodable {
    let likeStatus: Bool
    
    enum CodingKeys: String, CodingKey {
        case likeStatus = "like_status"
    }
}
