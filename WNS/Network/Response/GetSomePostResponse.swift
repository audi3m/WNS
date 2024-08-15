//
//  GetSomePostResponse.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct GetSomePostResponse: Decodable {
    let postID: String
    let productID: String?
    let title: String?
    let content: String?
    let content1: String?
    let content2: String?
    let content3: String?
    let content4: String?
    let content5: String?
    let createdAt: String
    let creater: Creater
    let files: [String]
    let likes: [String] // user_id
    let likes2: [String]?
    let hashTags: [String]
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case productID = "product_id"
        case title
        case content
        case content1
        case content2
        case content3
        case content4
        case content5
        case createdAt
        case creater
        case files
        case likes
        case likes2
        case hashTags
        case comments
    }
    
}

