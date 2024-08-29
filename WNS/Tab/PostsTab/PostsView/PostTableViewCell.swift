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
    
    let profileView = ProfileAndNicknameView()
    let imageBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        view.layer.masksToBounds = true
        return view
    }()
    let imageView1 = BasicImageView(frame: .zero)
    let imageView2 = BasicImageView(frame: .zero)
    let imageView3 = BasicImageView(frame: .zero)
    let moreView: UILabel = {
        let label = UILabel()
        label.text = "+ 1"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black.withAlphaComponent(0.6)
        return label
    }()
    let labelBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        view.layer.masksToBounds = true
        return view
    }()
    let wineNameLabel: UILabel = {
        let label = UILabel()
        label.text = "도그 포인트, 소비뇽 블랑 2017"
        label.font = .boldSystemFont(ofSize: 15)
        return label
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
        configureBasicView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetSubViews()
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
        setLikeButton(like: like)
    }
    
    func resetSubViews() {
        imageBackground.backgroundColor = .systemBackground
        imageView1.removeFromSuperview()
        imageView2.removeFromSuperview()
        imageView3.removeFromSuperview()
        moreView.removeFromSuperview()
    }
    
}

// View
extension PostTableViewCell {
    
    func configureImagesByCount() {
        guard let postData else { return }
        let creator = postData.creator
        profileView.setProfile(creator: creator)
        setLikeButton(like: like)
        
        switch postData.files.count {
        case 1: configureImage(post: postData)
        case 2: configureImages2(post: postData)
        case 3: configureImages3(post: postData)
        case 4: configureImages45(post: postData, count: 4)
        case 5: configureImages45(post: postData, count: 5)
        default:
            configureEmptyImage()
        }
    }
    
    private func configureEmptyImage() {
        imageBackground.backgroundColor = .systemGray4
    }
    
    private func configureImage(post: Post) {
        imageBackground.addSubview(imageView1)
        
        imageView1.setImageWithURL(with: post.files[0])
        imageView1.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
    private func configureImages2(post: Post) {
        imageBackground.addSubview(imageView1)
        imageBackground.addSubview(imageView2)

        imageView1.setImageWithURL(with: post.files[0])
        imageView2.setImageWithURL(with: post.files[1])
        
        imageView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(180)
        }
        imageView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
    private func configureImages3(post: Post) {
         
        imageBackground.addSubview(imageView1)
        imageBackground.addSubview(imageView2)
        imageBackground.addSubview(imageView3)
        
        imageView1.setImageWithURL(with: post.files[0])
        imageView2.setImageWithURL(with: post.files[1])
        imageView3.setImageWithURL(with: post.files[2])
        
        imageView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(180)
        }
        imageView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        imageView3.snp.makeConstraints { make in
            make.top.equalTo(imageView2.snp.bottom).offset(2)
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(imageView1.snp.bottom)
        }
    }
    
    private func configureImages45(post: Post, count: Int) {
         
        imageBackground.addSubview(imageView1)
        imageBackground.addSubview(imageView2)
        imageBackground.addSubview(imageView3)
        imageBackground.addSubview(moreView)
        
        imageView1.setImageWithURL(with: post.files[0])
        imageView2.setImageWithURL(with: post.files[1])
        imageView3.setImageWithURL(with: post.files[2])
        
        imageView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(180)
        }
        imageView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        imageView3.snp.makeConstraints { make in
            make.top.equalTo(imageView2.snp.bottom).offset(2)
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(imageView1.snp.bottom)
        }
        moreView.snp.makeConstraints { make in
            make.top.equalTo(imageView2.snp.bottom).offset(2)
            make.leading.equalTo(imageView1.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(imageView1.snp.bottom)
        }
        
        moreView.text = "+ \(count-2)"
        
    }
    
    func configureBasicView() {
        contentView.addSubview(profileView)
        contentView.addSubview(imageBackground)
        contentView.addSubview(labelBackground)
        labelBackground.addSubview(likeButton)
//        labelBackground.addSubview(commentsButton)
        labelBackground.addSubview(wineNameLabel)
        
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        imageBackground.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(180)
        }
        labelBackground.snp.makeConstraints { make in
            make.top.equalTo(imageBackground.snp.bottom).offset(2)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(70)
            make.bottom.equalToSuperview().offset(-30)
        }
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(labelBackground)
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalTo(25)
        }
        wineNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(labelBackground)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(likeButton.snp.leading).inset(-15)
        }
        
//        commentsButton.snp.makeConstraints { make in
//            
//        }
        
        imageBackground.backgroundColor = .systemBackground
        likeButton.addTarget(self, action: #selector(likePostTapped), for: .touchUpInside)
        commentsButton.addTarget(self, action: #selector(commentsButtonTapped), for: .touchUpInside)
    }
    
}
