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
    func configureBordersAndCorners(option: BorderOption, borderColor: UIColor) {
        
        // 좌우 테두리
        addBorder(to: [.left, .right], color: borderColor)
        
        switch option {
        case .topBorderOnly:
            addBorder(to: .top, color: borderColor)
        case .bottomBorderOnly:
            addBorder(to: .bottom, color: borderColor)
        case .topBorderWithCorner:
            addBorder(to: .top, color: borderColor)
            roundCorners(.top)
        case .bottomBorderWithCorner:
            addBorder(to: .bottom, color: borderColor)
            roundCorners(.bottom)
        }
    }
    
    private func addBorder(to edges: UIRectEdge, color: UIColor) {
        if edges.contains(.top) {
            let topBorder = UIView()
            topBorder.backgroundColor = color
            topBorder.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 2)
            self.addSubview(topBorder)
        }
        
        if edges.contains(.left) {
            let leftBorder = UIView()
            leftBorder.backgroundColor = color
            leftBorder.frame = CGRect(x: 0, y: 0, width: 2, height: self.frame.height)
            self.addSubview(leftBorder)
        }
        
        if edges.contains(.bottom) {
            let bottomBorder = UIView()
            bottomBorder.backgroundColor = color
            bottomBorder.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
            self.addSubview(bottomBorder)
        }
        
        if edges.contains(.right) {
            let rightBorder = UIView()
            rightBorder.backgroundColor = color
            rightBorder.frame = CGRect(x: self.frame.width - 2, y: 0, width: 2, height: self.frame.height)
            self.addSubview(rightBorder)
        }
    }
    
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

//extension UIView {
//    func addBorder(to edges: UIRectEdge, color: UIColor) {
//        if edges.contains(.top) || edges.contains(.all) {
//            let topBorder = UIView()
//            topBorder.backgroundColor = color
//            topBorder.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 2)
//            self.addSubview(topBorder)
//        }
//        
//        if edges.contains(.left) || edges.contains(.all) {
//            let leftBorder = UIView()
//            leftBorder.backgroundColor = color
//            leftBorder.frame = CGRect(x: 0, y: 0, width: 2, height: self.frame.height)
//            self.addSubview(leftBorder)
//        }
//        
//        if edges.contains(.bottom) || edges.contains(.all) {
//            let bottomBorder = UIView()
//            bottomBorder.backgroundColor = color
//            bottomBorder.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
//            self.addSubview(bottomBorder)
//        }
//        
//        if edges.contains(.right) || edges.contains(.all) {
//            let rightBorder = UIView()
//            rightBorder.backgroundColor = color
//            rightBorder.frame = CGRect(x: self.frame.width - 2, y: 0, width: 2, height: self.frame.height)
//            self.addSubview(rightBorder)
//        }
//    }
//}
