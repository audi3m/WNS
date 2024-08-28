//
//  OutlineField.swift
//  WNS
//
//  Created by J Oh on 8/28/24.
//
 
import UIKit

final class OutlineField: UIView {
     
    lazy var outlineView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.5
        view.roundCorners(cornerType)
        return view
    }()
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "envelope.fill")
        view.tintColor = .lightGray
        view.contentMode = .scaleAspectFit
        return view
    }()
    let duplicationButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        return button
    }()
    let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "이메일"
        field.font = .systemFont(ofSize: 15)
        return field
    }()
    let textView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 15)
        
        return view
    }()
    
    let fieldType: FieldType
    let cornerType: Corner
    
    init(fieldType: FieldType, cornerType: Corner) {
        self.fieldType = fieldType
        self.cornerType = cornerType
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(outlineView)
        outlineView.addSubview(iconImageView)
        
        outlineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.size.equalTo(30)
        }
        
        if fieldType == .contents {
            outlineView.addSubview(textView)
            textView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.leading.equalTo(iconImageView.snp.trailing).offset(10)
                make.trailing.bottom.equalToSuperview().inset(10)
            }
        } else {
            outlineView.addSubview(textField)
            
            if fieldType == .email {
                outlineView.addSubview(duplicationButton)
                
                duplicationButton.snp.makeConstraints { make in
                    make.verticalEdges.trailing.equalToSuperview().inset(10)
                    make.width.equalTo(50)
                }
                textField.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(10)
                    make.leading.equalTo(iconImageView.snp.trailing).offset(10)
                    make.trailing.equalTo(duplicationButton.snp.leading).offset(-10)
                    make.bottom.equalToSuperview().inset(10)
                }
                
            } else {
                textField.snp.makeConstraints { make in
                    make.leading.equalTo(iconImageView.snp.trailing).offset(10)
                    make.verticalEdges.trailing.equalToSuperview().inset(10)
                }
            }
        }
        
        iconImageView.image = UIImage(systemName: fieldType.image)
        textField.placeholder = fieldType.placeholder
    }
}
 
extension OutlineField {
    enum FieldType {
        case email, password, nickname, birthday, phone, contents
        
        var placeholder: String {
            switch self {
            case .email:
                "이메일 ex) aaa@aaa.com"
            case .password:
                "비밀번호"
            case .nickname:
                "닉네임 - 공백 없이 입력"
            case .birthday:
                "생년월일 8자리 ex) 20010710"
            case .phone:
                "[선택] 전화번호 - 숫자만 입력"
            default:
                ""
            }
        }
        
        var image: String {
            switch self {
            case .email:
                "envelope"
            case .password:
                "lock"
            case .nickname:
                "person"
            case .birthday:
                "birthday.cake"
            case .phone:
                "phone"
            case .contents:
                "pencil"
            }
        }
    }
    
    enum CornerType {
        case top, middle, bottom
    }
}
