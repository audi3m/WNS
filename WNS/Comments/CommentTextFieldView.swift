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
        return view
    }()
    let commentField: UITextField = {
        let field = UITextField()
        field.placeholder = "댓글 달기..."
        field.borderStyle = .roundedRect
        return field
    }()
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.circle"), for: .normal)
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
        addSubview(commentField)
        addSubview(sendButton)
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
            make.size.equalTo(30)
        }
        
        commentField.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
        }
        
    }
}

