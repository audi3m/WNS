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
    
    static let postButton = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .medium))?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(paletteColors: [.white, .systemPurple]))
    
    
    
    
    
}
