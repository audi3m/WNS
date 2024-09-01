//
//  PostSectionView.swift
//  WNS
//
//  Created by J Oh on 9/1/24.
//

import UIKit
import SnapKit

final class PostSectionView: UIView {
    
    lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "게시물 제목"
        return label
    }()
    let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    let hashtagsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        return label
    }()
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(sectionTitleLabel)
        addSubview(backgroundColorView)
        
        backgroundColorView.addSubview(hashtagsLabel)
        backgroundColorView.addSubview(dateLabel)
        backgroundColorView.addSubview(contentsLabel)
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        backgroundColorView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitleLabel.snp.bottom).offset(13)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        hashtagsLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(DesignSize.fieldPadding)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(hashtagsLabel.snp.bottom).offset(3)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldPadding)
        }
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview().inset(DesignSize.fieldPadding)
        }
        
         
        
    }
    
    func setData(post: Post) {
        sectionTitleLabel.text = post.title
        hashtagsLabel.text = post.hashTagsString
        dateLabel.text = post.longDate
        contentsLabel.text = post.content2
    }
    
}

