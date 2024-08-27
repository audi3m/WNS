//
//  CountAndLabelView.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import UIKit
import SnapKit

final class CountAndLabelView: UIView {
    
    enum CountType: String {
        case posts = "게시물"
        case followers = "팔로워"
        case followings = "팔로잉"
    }
    
    let countLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = type.rawValue
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let type: CountType
    
    init(type: CountType) {
        self.type = type
        super.init(frame: .zero)
        configureView()
    }
 
    override init(frame: CGRect) {
        self.type = .posts
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(countLabel)
        addSubview(nameLabel)
        
        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        countLabel.text = "\(Int.random(in: 100..<1000))"
        nameLabel.text = type.rawValue
    }
    
    
    
}
