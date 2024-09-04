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
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
        titleLabel.text = "[제목]"
        contentsLabel.text = "[내용]"
    }
     
    private func configureView() {
        contentView.addSubview(backgroundColorView)
        
        backgroundColorView.addSubview(responseLabel)
        backgroundColorView.addSubview(titleLabel)
        backgroundColorView.addSubview(lineView)
        backgroundColorView.addSubview(contentsLabel)
        
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
            make.height.equalTo(25)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(DesignSize.fieldPadding/2)
            make.leading.equalToSuperview().offset(DesignSize.fieldPadding)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(1)
        }
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(DesignSize.fieldPadding/2)
            make.leading.equalToSuperview().offset(DesignSize.fieldPadding)
            make.height.greaterThanOrEqualTo(100)
            make.bottom.equalToSuperview().inset(DesignSize.fieldPadding)
        } 
    }
    
    func setData(post: Post) {
        titleLabel.text = "[제목] \(post.content1 ?? "")"
        contentsLabel.text = "[내용]\n\(post.content2 ?? "")"
    }
    
}
