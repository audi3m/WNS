//
//  TabItemsImage.swift
//  WNS
//
//  Created by J Oh on 8/20/24.
//

import UIKit

enum TabItemsImage {
    
    case home
    case addNew
    case profile
    
    var unselectedImage: UIImage {
        switch self {
        case .home:
            UIImage(systemName: "house") ?? UIImage()
        case .addNew:
            UIImage(systemName: "plus.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)) ?? UIImage()
        case .profile:
            UIImage(systemName: "person.circle") ?? UIImage()
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home:
            UIImage(systemName: "house.fill") ?? UIImage()
        case .addNew:
            UIImage(systemName: "plus.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)) ?? UIImage()
        case .profile:
            UIImage(systemName: "person.circle.fill") ?? UIImage()
        }
    }
    
    
    
}
