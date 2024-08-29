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
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .systemMint
        view.layer.cornerRadius = 18
        return view
    }()
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    var data: Comment?
     
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
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(commentLabel)
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(15)
            make.size.equalTo(36)
            make.bottom.equalTo(contentView).offset(-15)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView).offset(-15)
            make.height.equalTo(15)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView).offset(-15)
            make.height.equalTo(15)
        }
    }
    
    func configureData() {
        guard let data else { return }
        if let image = data.creator.profileImage {
            profileImageView.setImageWithURL(with: image)
        } else {
            profileImageView.image = UIImage(systemName: "person.circle")
        }
        nicknameLabel.text = data.creator.nick
        commentLabel.text = data.content
    }
}



