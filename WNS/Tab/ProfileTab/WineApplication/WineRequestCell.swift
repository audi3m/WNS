//
//  WineRequestCell.swift
//  WNS
//
//  Created by J Oh on 9/2/24.
//

import UIKit
import SnapKit

final class WineRequestCell: UITableViewCell {
    
    let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let grapeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let regionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let wineryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
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
        nameLabel.text = "[이름] "
        grapeLabel.text = "[품종] "
        countryLabel.text = "[국가] "
        regionLabel.text = "[지역] "
        wineryLabel.text = "[생산] "
    }
     
    private func configureView() {
        contentView.addSubview(backgroundColorView)
        
        backgroundColorView.addSubview(responseLabel)
        backgroundColorView.addSubview(nameLabel)
        backgroundColorView.addSubview(grapeLabel)
        backgroundColorView.addSubview(countryLabel)
        backgroundColorView.addSubview(regionLabel)
        backgroundColorView.addSubview(wineryLabel)
        
        backgroundColorView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(DesignSize.fieldPadding/2)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldPadding)
        }
        responseLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(DesignSize.fieldPadding)
            make.height.equalTo(25)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.height.equalTo(15)
        }
        grapeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.height.equalTo(15)
        }
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(grapeLabel.snp.bottom)
            make.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.height.equalTo(15)
        }
        regionLabel.snp.makeConstraints { make in
            make.top.equalTo(countryLabel.snp.bottom)
            make.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.height.equalTo(15)
        }
        wineryLabel.snp.makeConstraints { make in
            make.top.equalTo(regionLabel.snp.bottom)
            make.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.height.equalTo(15)
            make.bottom.equalToSuperview().offset(-DesignSize.fieldPadding)
        }
    }
    
    func setData(post: Post) {
        nameLabel.text = "[이름] \(post.content1 ?? "")"
        grapeLabel.text = "[품종] \(post.content2 ?? "")"
        countryLabel.text = "[국가] \(post.content3 ?? "")"
        regionLabel.text = "[지역] \(post.content4 ?? "")"
        wineryLabel.text = "[생산] \(post.content5 ?? "")"
        if let comment = post.comments.last {
            responseLabel.text = "  \(comment.content)  "
            if comment.content == "추가완료" {
                responseLabel.backgroundColor = .systemGreen
            }
        } else {
            responseLabel.text = "  확인중  "
        }
    }
    
}
