//
//  AppearanceCollectionViewCell.swift
//  WNS
//
//  Created by J Oh on 8/26/24.
//

import UIKit
import SnapKit

struct Appearance {
    
    
    
}

final class AppearanceCollectionViewCell: UICollectionViewCell {
    
    enum AppearanceMode: String, CaseIterable {
        case system = "System"
        case light = "Light"
        case dark = "Dark"

        var iconName: String {
            switch self {
            case .system: return "iphone"
            case .light: return "sun.max"
            case .dark: return "moon"
            }
        }
    }
    
    let systemImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "iphone")
        return view
    }()
    
    let sunImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun")
        
        return view
    }()
    
    let moonImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "iphone")
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
     
      
}
