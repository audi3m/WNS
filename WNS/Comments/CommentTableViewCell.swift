//
//  CommentTableViewCell.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import UIKit
import SnapKit

final class CommentTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemMint
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(commentLabel)
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(15)
            make.size.equalTo(40)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
            
        }
        
        
        
        
    }
}



