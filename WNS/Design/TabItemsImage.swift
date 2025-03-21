//
//  TabItemsImage.swift
//  WNS
//
//  Created by J Oh on 8/20/24.
//

import UIKit

enum TabItemImage {
    
    case home
    case search
    case addNew
    case join
    case login
    case profile
    
    var unselectedImage: UIImage {
        switch self {
        case .home:
            UIImage(systemName: "house") ?? UIImage()
        case .search:
            UIImage(systemName: "magnifyingglass") ?? UIImage()
        case .addNew:
            UIImage(systemName: "plus.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)) ?? UIImage()
        case .join:
            UIImage(systemName: "pencil.and.scribble", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)) ?? UIImage()
        case .login:
            UIImage(systemName: "key", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)) ?? UIImage()
        case .profile:
            UIImage(systemName: "person.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)) ?? UIImage()
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home:
            UIImage(systemName: "house.fill") ?? UIImage()
        case .search:
            UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)) ?? UIImage()
        case .addNew:
            UIImage(systemName: "plus.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)) ?? UIImage()
        case .join:
            UIImage(systemName: "pencil.and.scribble", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)) ?? UIImage()
        case .login:
            UIImage(systemName: "key", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)) ?? UIImage()
        case .profile:
            UIImage(systemName: "person.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)) ?? UIImage()
        }
    }
    
    
    
}
