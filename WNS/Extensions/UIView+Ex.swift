//
//  UIView+Ex.swift
//  WNS
//
//  Created by J Oh on 8/28/24.
//

import UIKit

enum BorderOption {
    case topBorderOnly
    case bottomBorderOnly
    case topBorderWithCorner
    case bottomBorderWithCorner
}

enum Corner {
    case top, middle, bottom
}

extension UIView {
    
    func roundCorners(_ corners: Corner) {
        var maskedCorners: CACornerMask = []
        
        switch corners {
        case .top:
            maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .middle:
            maskedCorners = []
        case .bottom:
            maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = maskedCorners
    }
}
