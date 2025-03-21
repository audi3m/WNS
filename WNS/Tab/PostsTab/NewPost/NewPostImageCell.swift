//
//  NewPostImageCell.swift
//  WNS
//
//  Created by J Oh on 8/24/24.
//

import UIKit
import SnapKit

class NewPostImageCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1.5
        view.backgroundColor = .systemGray4
        return view
    }()
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonImage.deleteButton, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setImage(name: String) {
        imageView.image = UIImage(named: name)
    }
    
}

extension NewPostImageCell {
    func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
        
        imageView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.size.equalTo(70)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(24)
        }
    }
}
