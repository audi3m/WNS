//
//  InquiryCell.swift
//  WNS
//
//  Created by J Oh on 9/2/24.
//

import UIKit
import SnapKit

final class InquiryCell: UITableViewCell {
    
    let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    let responseLabel: UILabel = {
        let label = UILabel()
        label.text = "  확인중  "
        label.font = .systemFont(ofSize: 13)
        label.backgroundColor = .systemGray4
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonImage.trash, for: .normal)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetData()
    }
    
    private func resetData() {
        titleLabel.text = ""
        contentsLabel.text = ""
    }
     
    private func configureView() {
        contentView.addSubview(backgroundColorView)
        
        backgroundColorView.addSubview(responseLabel)
        backgroundColorView.addSubview(titleLabel)
        backgroundColorView.addSubview(contentsLabel)
        backgroundColorView.addSubview(deleteButton)
        
        backgroundColorView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(DesignSize.fieldPadding/2)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldPadding)
        }
        responseLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(DesignSize.fieldPadding)
            make.height.equalTo(25)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.height.equalTo(15)
        }
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.height.greaterThanOrEqualTo(100)
        }
        deleteButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(DesignSize.fieldPadding)
            make.size.equalTo(25)
        }
    }
    
    func setData(post: Post) {
        titleLabel.text = post.content1
        contentsLabel.text = post.content2
    }
    
}
