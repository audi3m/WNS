//
//  PostImageCollectionViewCell.swift
//  WNS
//
//  Created by J Oh on 8/25/24.
//

import UIKit
import SnapKit

final class PostImageCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(fileURL: String) {
        imageView.setImageWithURL(with: fileURL)
    }
    
}
