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
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 2
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
        contentView.addSubview(userNameLabel)
        contentView.addSubview(commentLabel)
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(15)
            make.size.equalTo(36)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
            make.height.equalTo(30)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
    }
    
    func configureData() {
        guard let data else { return }
        
        profileImageView.image = UIImage(systemName: "person.circle")
        userNameLabel.text = data.creator.nick
        commentLabel.text = data.content
    }
}



