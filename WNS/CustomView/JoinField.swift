//
//  JoinField.swift
//  WNS
//
//  Created by J Oh on 8/17/24.
//

import UIKit
import SnapKit

enum FieldType {
    case email, password, nickname, phoneNumber, title, hashtag
}

final class JoinField: UIView {
    
    let type: FieldType
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "  이메일 주소  " 
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .systemBackground
        return label
    }()
    let textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 15)
        return field
    }()
//    let validationLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 12)
//        return label
//    }()
 
    
    init(type: FieldType) {
        self.type = type
        super.init(frame: .zero)
        configureView()
    }
 
    override init(frame: CGRect) {
        self.type = .email
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(textField)
        addSubview(titleLabel)
//        addSubview(validationLabel)

        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(textField.snp.leading).offset(8)
            make.centerY.equalTo(textField.snp.top)
            make.height.equalTo(12)
        }

//        validationLabel.snp.makeConstraints { make in
//            make.top.equalTo(textField.snp.bottom).offset(8)
//            make.leading.equalTo(textField.snp.leading).offset(4)
//            make.height.equalTo(12)
//            make.bottom.equalToSuperview()
//        }
        
        switch type {
        case .email:
            titleLabel.text = "  이메일 주소  "
            textField.placeholder = "ex) aaa@aaa.com"
        case .password:
            titleLabel.text = "  비밀번호  "
            textField.placeholder = "8자리 이상"
        case .nickname:
            titleLabel.text = "  닉네임 (선택)  "
            textField.placeholder = ""
        case .phoneNumber:
            titleLabel.text = "  전화번호 (선택)  "
            textField.placeholder = ""
        case .title:
            titleLabel.text = "  제목  "
            textField.placeholder = ""
        case .hashtag:
            titleLabel.text = "  해시태그  "
            textField.placeholder = "띄어쓰기 없이 입력 후 엔터"
            
        }
    }
}
