//
//  CommentTextFieldView.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import UIKit
import SnapKit

final class CommentTextFieldView: UIView {
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.image = UIImage(systemName: "person.circle")
        view.tintColor = .label
        return view
    }()
    let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "댓글 달기..."
        field.borderStyle = .roundedRect
        return field
    }()
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonImage.sendButton, for: .normal)
        button.tintColor = .label
        return button
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(profileImageView)
        addSubview(textField)
        addSubview(sendButton)
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
            make.size.equalTo(30)
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
            make.trailing.equalTo(sendButton.snp.leading).offset(-15)
            make.height.equalTo(44)
        }
        
        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
            make.size.equalTo(30)
        }
        
    }
}

