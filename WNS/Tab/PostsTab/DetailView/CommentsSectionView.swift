//
//  CommentsSectionView.swift
//  WNS
//
//  Created by J Oh on 9/3/24.
//

import UIKit
import SnapKit

final class CommentsSectionView: UIView {
    
    let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "댓글"
        return label
    }()
    let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        return view
    }()
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
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
        addSubview(countLabel)
        addSubview(backgroundColorView)
        backgroundColorView.addSubview(commentsLabel)
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sectionTitleLabel.snp.centerY)
            make.leading.equalTo(sectionTitleLabel.snp.trailing).offset(12)
        }
        backgroundColorView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitleLabel.snp.bottom).offset(13)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        commentsLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(DesignSize.fieldPadding)
        }
    }
    
    func setComments(comments: [Comment]) {
        countLabel.text = "\(comments.count)"
        let attributedText = NSMutableAttributedString()
        
        if comments.isEmpty {
            commentsLabel.text = "댓글이 없습니다"
            commentsLabel.textColor = .secondaryLabel
        } else {
            for (index, comment) in comments.prefix(3).enumerated() {
                let boldAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 14)
                ]
                let defaultAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 13)
                ]
                
                let nickString = NSAttributedString(string: "\(comment.creator.nick) ", attributes: boldAttributes)
                let contentString = NSAttributedString(string: "\(comment.content)", attributes: defaultAttributes)
                
                attributedText.append(nickString)
                attributedText.append(contentString)
                
                if index < comments.prefix(3).count - 1 {
                    attributedText.append(NSAttributedString(string: "\n"))
                }
            }
            
            commentsLabel.attributedText = attributedText
        }
    }
    
}
