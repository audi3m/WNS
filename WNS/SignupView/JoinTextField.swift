//
//  JoinTextField.swift
//  WNS
//
//  Created by J Oh on 8/16/24.
//

import UIKit
import SnapKit

enum FieldType {
    case email
    case password
    case nickname
    case phone
}

final class JoinTextField: UIView {
    
    let type: FieldType

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "이메일 주소"
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 15)
        return field
    }()
    let validationLabel: UILabel = {
        let label = UILabel()
        label.text = "유효한 이메일입니다"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
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
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(validationLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(13)
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }

        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.height.equalTo(12)
            make.bottom.equalToSuperview()
        }
        
        switch type {
        case .email:
            titleLabel.text = "- 이메일 주소 *"
            textField.placeholder = "이메일 주소 ex) a@a.com"
        case .password:
            titleLabel.text = "- 비밀번호 *"
            textField.placeholder = "비밀번호를 입력하세요"
        case .nickname:
            titleLabel.text = "닉네임 (선택)"
            textField.placeholder = "사용할 닉네임을 입력하세요"
        case .phone:
            titleLabel.text = "전화번호 (선택)"
            textField.placeholder = "전화번호를 입력하세요"
        }
    }
}
