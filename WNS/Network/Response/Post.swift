//
//  Post.swift
//  WNS
//
//  Created by J Oh on 8/15/24.
//

import Foundation

struct Post: Decodable {
    let postID: String
    let productID: String?
    let title: String?
    let price: Int?
    let content: String?
    let content1: String?
    let content2: String?
    let content3: String?
    let content4: String?
    let content5: String?
    let createdAt: String
    let creator: Creator
    let files: [String] // dir
    let likes: [String] // user_id
    let likes2: [String]?
    let hashTags: [String]
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case productID = "product_id"
        case title
        case price
        case content
        case content1
        case content2
        case content3
        case content4
        case content5
        case createdAt
        case creator
        case files
        case likes
        case likes2
        case hashTags
        case comments
    }
    
    var likeThisPost: Bool {
        likes.contains(AccountManager.shared.userID)
    }
    
    var hashTagsString: String {
        hashTags.dropFirst().map { "#\($0)" }.joined(separator: " ")
    }
    
    var shortDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoFormatter.date(from: createdAt) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M월 d일"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")

            let result = dateFormatter.string(from: date)
            return result
        }
        return "DATE UNKNOWN"
    }
    
    var longDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoFormatter.date(from: createdAt) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 M월 d일 H시 m분"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")

            let result = dateFormatter.string(from: date)
            return result
        }
        return "DATE UNKNOWN"
    }
}

struct Creator: Decodable, Hashable {
    let userID: String
    let nick: String
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nick
        case profileImage
    }
}

struct Comment: Decodable, Hashable {
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        lhs.commentID == rhs.commentID
    }
    
    let commentID: String
    let content: String
    let createdAt: String
    let creator: Creator
    
    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case content
        case createdAt
        case creator
    }
}
