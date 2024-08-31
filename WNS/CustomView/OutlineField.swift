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
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = DesignSize.outlineWidth
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
    lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "이메일"
        field.font = .systemFont(ofSize: 15)
        field.keyboardType = fieldType.keyboardType
        field.autocapitalizationType = .none
        return field
    }()
    let textView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    let contentsPlaceholder: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .placeholderText
        label.text = "내용"
        return label
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
            make.top.leading.equalToSuperview().inset(DesignSize.fieldPadding)
            make.size.equalTo(DesignSize.fieldHeight - DesignSize.fieldPadding * 2)
        }
        
        if fieldType == .contents {
            outlineView.addSubview(textView)
            textView.snp.makeConstraints { make in
                make.verticalEdges.trailing.equalToSuperview().inset(DesignSize.fieldPadding)
                make.leading.equalTo(iconImageView.snp.trailing).offset(DesignSize.fieldPadding)
            }
        } else {
            outlineView.addSubview(textField)
            
            if fieldType == .email {
                outlineView.addSubview(duplicationButton)
                
                duplicationButton.snp.makeConstraints { make in
                    make.verticalEdges.equalToSuperview().inset(10)
                    make.trailing.equalToSuperview().inset(DesignSize.fieldPadding)
                    make.width.equalTo(50)
                }
                textField.snp.makeConstraints { make in
                    make.verticalEdges.equalToSuperview().inset(DesignSize.fieldPadding)
                    make.leading.equalTo(iconImageView.snp.trailing).offset(DesignSize.fieldPadding)
                    make.trailing.equalTo(duplicationButton.snp.leading).offset(-DesignSize.fieldPadding)
                }
                
            } else {
                textField.snp.makeConstraints { make in
                    make.leading.equalTo(iconImageView.snp.trailing).offset(DesignSize.fieldPadding)
                    make.verticalEdges.trailing.equalToSuperview().inset(DesignSize.fieldPadding)
                }
            }
        }
        
        iconImageView.image = switch fieldType {
        case .variety, .winery:
            UIImage(named: fieldType.image)
        default:
            UIImage(systemName: fieldType.image)
        }
        textField.placeholder = fieldType.placeholder
    }
}
 
extension OutlineField {
    enum FieldType {
        case email, emailForLogin, password, passwordForLogin, nickname, birthday, phone, contents, hashtag, title
        case wineName, variety, country, region, winery
        // 이름, 품종, 국가, 지역, 와이너리
        var placeholder: String {
            switch self {
            case .email:
                "이메일 ex) aaa@aaa.com"
            case .emailForLogin:
                "이메일"
            case .password:
                "비밀번호 (8자리 이상)"
            case .passwordForLogin:
                "비밀번호"
            case .nickname:
                "닉네임 (공백 없이 입력)"
            case .birthday:
                "생년월일 8자리 ex) 20010710"
            case .phone:
                "[선택] 전화번호 (숫자만 입력)"
            case .hashtag:
                "#해시태그"
            case .title:
                "제목"
            case .contents:
                ""
            case .wineName:
                "와인 이름"
            case .variety:
                "품종"
            case .country:
                "국가"
            case .region:
                "지역"
            case .winery:
                "와이너리"
            }
        }
        
        var image: String {
            switch self {
            case .email, .emailForLogin:
                "envelope"
            case .password, .passwordForLogin:
                "lock"
            case .nickname:
                "person"
            case .birthday:
                "birthday.cake"
            case .phone:
                "phone"
            case .contents:
                "text.quote"
            case .hashtag:
                "number"
            case .title:
                "pencil"
            case .wineName:
                "tag"
            case .variety:
                "grapes"
            case .country:
                "globe"
            case .region:
                "map"
            case .winery:
                "winery"
            }
        }
        
        var keyboardType: UIKeyboardType {
            switch self {
            case .email, .emailForLogin:
                return .emailAddress
            case .birthday, .phone:
                return .numberPad
            default:
                return .default
            }
        }
    }
    
    enum CornerType {
        case top, middle, bottom
    }
}
