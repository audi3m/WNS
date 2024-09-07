//
//  PostSectionView.swift
//  WNS
//
//  Created by J Oh on 9/1/24.
//

import UIKit
import SnapKit

final class PostSectionView: UIView {
    
    let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        return view
    }()
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        view.addArrangedSubview(hashtagsLabel)
        view.addArrangedSubview(contentsLabel)
        view.addArrangedSubview(dateLabel)
        return view
    }()
    let hashtagsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        return label
    }()
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
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
        addSubview(backgroundColorView)
        backgroundColorView.addSubview(stackView)
        
        backgroundColorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.bottom.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundColorView).inset(DesignSize.fieldPadding)
        }
    }
    
    func setData(post: Post) {
        hashtagsLabel.text = post.hashTagsString
        dateLabel.text = post.longDate
        contentsLabel.text = post.content2
    }
}

