//
//  BasicImageView.swift
//  WNS
//
//  Created by J Oh on 8/25/24.
//

import UIKit

class BasicImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
        layer.cornerRadius = DesignSize.fieldCornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
