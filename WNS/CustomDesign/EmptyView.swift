//
//  EmptyView.swift
//  WNS
//
//  Created by J Oh on 8/23/24.
//

import UIKit
import SnapKit
 
final class EmptyView: UIView {
    
    enum EmptyType {
        case comments
        case posts
        
        var mainText: String {
            switch self {
            case .comments:
                "아직 댓글이 없습니다"
            case .posts:
                "게시물이 없습니다"
            }
        }
        var subText: String {
            switch self {
            case .comments:
                "댓글을 남겨보세요"
            case .posts:
                "게시물을 작성해보세요"
            }
        }
    }
     
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    let subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
     
    let type: EmptyType
    
    init(type: EmptyType) {
        self.type = type
        super.init(frame: .zero)
        configureView()
    }
 
    override init(frame: CGRect) {
        self.type = .comments
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(mainLabel)
        addSubview(subLabel)

        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        }
        
        mainLabel.text = type.mainText
        subLabel.text = type.subText
         
    }
}
