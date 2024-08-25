//
//  PostTableViewCell.swift
//  WNS
//
//  Created by J Oh on 8/17/24.
//

import UIKit
import SnapKit

protocol PostCellDelegate: AnyObject {
    func commentsButtonTapped(in cell: UITableViewCell, postID: String)
}

final class PostTableViewCell: UITableViewCell {
    
    let profileView: ProfileAndNicknameView = {
        let view = ProfileAndNicknameView()
        return view
    }()
    let postImagesView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonImage.heart, for: .normal)
        button.tintColor = .label
        return button
    }()
    let commentsButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonImage.bubble, for: .normal)
        button.tintColor = .label
        return button
    }()
    let hashtagLabel: UILabel = {
        let label = UILabel()
        label.text = "#레드 #본테라 #화이트"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemBlue
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "레드 와인"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "내용\n내용\n내용"
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    var postData: Post?
    var like: Bool = false {
        didSet {
            setLikeButton(like: like)
        }
    }
    
    weak var delegate: PostCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureView()
        configureData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// Tap Functions
extension PostTableViewCell {
    
    @objc func likePostTapped() {
        like = !like
        setLikeButton(like: like)
        guard let postData else { return }
        let body = LikeBody(like_status: like)
        
        NetworkManager.shared.like(postID: postData.postID, body: body) { response in
            DispatchQueue.main.async {
                let like = response.likeStatus
                self.setLikeButton(like: like)
            }
        }
    }
    
    @objc func commentsButtonTapped() {
        guard let postID = postData?.postID else { return }
        delegate?.commentsButtonTapped(in: self, postID: postID)
    }
    
    private func setLikeButton(like: Bool) {
        let image = like ? ButtonImage.heartFill : ButtonImage.heart
        likeButton.setImage(image, for: .normal)
        likeButton.tintColor = like ? .systemPink : .label
    }
    
}

extension PostTableViewCell {
    func configureData() {
        guard let postData else { return }
        let creator = postData.creator
        profileView.setProfile(creator: creator)
        titleLabel.text = postData.title
        bodyLabel.text = postData.content
        
        setLikeButton(like: like)
        
    }
     
}

// View
extension PostTableViewCell {
    
    private func configureView() {
        
        contentView.addSubview(profileView)
        contentView.addSubview(postImagesView)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentsButton)
        contentView.addSubview(hashtagLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(15)
        }
        
        postImagesView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postImagesView.snp.bottom).offset(8)
            make.leading.equalTo(contentView).offset(15)
            make.size.equalTo(30)
        }
        
        commentsButton.snp.makeConstraints { make in
            make.top.equalTo(postImagesView.snp.bottom).offset(8)
            make.leading.equalTo(likeButton.snp.trailing).offset(15)
            make.size.equalTo(30)
        }
        
        hashtagLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(hashtagLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(20)
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        likeButton.addTarget(self, action: #selector(likePostTapped), for: .touchUpInside)
        commentsButton.addTarget(self, action: #selector(commentsButtonTapped), for: .touchUpInside)
        
    }
    
}
