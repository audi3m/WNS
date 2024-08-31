//
//  GalleryButtonCell.swift
//  WNS
//
//  Created by J Oh on 8/24/24.
//

import UIKit
import SnapKit

class GalleryButtonCell: UICollectionViewCell {

    let galleryButton: GalleryButtonView = {
        let view = GalleryButtonView()
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = DesignSize.outlineWidth
        view.layer.cornerRadius = DesignSize.fieldCornerRadius
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(galleryButton)
        galleryButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.size.equalTo(70)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setCount(num: Int) {
        galleryButton.countLabel.text = "\(num) / 5"
    }
      
}
