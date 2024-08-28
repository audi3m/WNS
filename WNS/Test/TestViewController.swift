//
//  TestViewController.swift
//  WNS
//
//  Created by J Oh on 8/16/24.
//

import UIKit
import SnapKit

final class TestViewController: BaseViewController {
    
    let emailField = OutlineField(fieldType: .email, cornerType: .top)
    let passwordField = OutlineField(fieldType: .password, cornerType: .middle)
    let nickname = OutlineField(fieldType: .nickname, cornerType: .bottom)
    let contents = OutlineField(fieldType: .contents, cornerType: .middle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureBasicView()
        
    }
    
}

extension TestViewController {
    
    private func configureBasicView() {
        view.backgroundColor = .systemBackground
        
        
    }
    
    private func configureNavBar() {
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(nickname)
        view.addSubview(contents)
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        } 
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(-1.5)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        nickname.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(-1.5)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        contents.snp.makeConstraints { make in
            make.top.equalTo(nickname.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.greaterThanOrEqualTo(200)
        }
//        iconImageView.snp.makeConstraints { make in
//            make.verticalEdges.leading.equalToSuperview().inset(8)
//            make.width.equalTo(34)
//        }
//        textField.snp.makeConstraints { make in
//            make.verticalEdges.equalToSuperview().inset(8)
//            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
//            make.trailing.equalToSuperview().offset(-8)
//        }
    }
    
}



