//
//  ButtonImages.swift
//  WNS
//
//  Created by J Oh on 8/23/24.
//

import UIKit

enum ButtonImage {
    
    static let heart = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))?.withTintColor(.label)
    static let heartFill = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))?.withTintColor(.systemPink)
    static let bubble = UIImage(systemName: "bubble", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
    static let trash = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium))
    static let postButton = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .medium))?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(paletteColors: [.white, .systemPurple]))
    
    static let sendButton = UIImage(systemName: "arrow.up.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
    
    static let deleteButton = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(paletteColors: [.white, .lightGray]))
    static let closeButton = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .medium))?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(paletteColors: [.white, .whiteWine]))
    
    static let navLogin = UIImage(systemName: "arrow.right.square")
    static let navRefresh = UIImage(systemName: "arrow.circlepath")
    static let navProfile = UIImage(systemName: "person.fill")
    static let navCallPosts = UIImage(systemName: "square.and.arrow.down")
    
}
