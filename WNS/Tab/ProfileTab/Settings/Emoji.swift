//
//  Emoji.swift
//  WNS
//
//  Created by J Oh on 8/26/24.
//

import Foundation

struct Emoji: Hashable {

    enum Category: CaseIterable, CustomStringConvertible {
        case recents, smileys, nature
    }
    
    let text: String
    let title: String
    let category: Category
    private let id = UUID()
}

extension Emoji.Category {
    
    var description: String {
        switch self {
        case .recents: return "Recents"
        case .smileys: return "Smileys"
        case .nature: return "Nature"
        }
    }
    
    var emojis: [Emoji] {
        switch self {
        case .recents:
            return [
                Emoji(text: "🤣", title: "Rolling on the floor laughing", category: self),
                Emoji(text: "🥃", title: "Whiskey", category: self),
                Emoji(text: "😎", title: "Cool", category: self)
            ]
            
        case .smileys:
            return [
                Emoji(text: "😀", title: "Happy", category: self),
                Emoji(text: "😂", title: "Laughing", category: self),
                Emoji(text: "🤣", title: "Rolling on the floor laughing", category: self)
            ]
            
        case .nature:
            return [
                Emoji(text: "🦊", title: "Fox", category: self),
                Emoji(text: "🐝", title: "Bee", category: self),
                Emoji(text: "🐢", title: "Turtle", category: self)
            ]
        }
    }
}
