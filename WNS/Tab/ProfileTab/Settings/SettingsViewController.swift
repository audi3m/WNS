//
//  SettingsViewController.swift
//  WNS
//
//  Created by J Oh on 8/20/24.
//

import UIKit
import SnapKit

final class SettingsViewController: BaseViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let appearanceOutline: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(systemAppearance)
        view.addArrangedSubview(lightAppearance)
        view.addArrangedSubview(darkAppearance)
        view.axis = .horizontal
        view.distribution = .equalSpacing
        return view
    }()
    
    private lazy var systemAppearance: UIButton = {
        let button = UIButton()
        button.tintColor = .lightGray
        button.setImage(UIImage(systemName: "iphone", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        button.addTarget(self, action: #selector(systemClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var lightAppearance: UIButton = {
        let button = UIButton()
        button.tintColor = .lightGray
        button.setImage(UIImage(systemName: "sun.max", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        button.addTarget(self, action: #selector(lightClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var darkAppearance: UIButton = {
        let button = UIButton()
        button.tintColor = .lightGray
        button.setImage(UIImage(systemName: "moon", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        button.addTarget(self, action: #selector(darkClicked), for: .touchUpInside)
        return button
    }()
    
    private let wineRequest = OutlineButton(name: "와인 추가 신청", cornerType: .top)
    private let editProfile = OutlineButton(name: "프로필 수정", cornerType: .middle)
    private let what = OutlineButton(name: "뭐가 필요할까", cornerType: .bottom)
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setButtons()
    }
}

// Appearance Functions
extension SettingsViewController {
    
    @objc private func systemClicked() {
        systemAppearance.tintColor = .label
        lightAppearance.tintColor = .lightGray
        darkAppearance.tintColor = .lightGray
    }
    
    @objc private func lightClicked() {
        systemAppearance.tintColor = .lightGray
        lightAppearance.tintColor = .label
        darkAppearance.tintColor = .lightGray
    }
    
    @objc private func darkClicked() {
        systemAppearance.tintColor = .lightGray
        lightAppearance.tintColor = .lightGray
        darkAppearance.tintColor = .label
    }
    
    @objc private func addWineClicked() {
        print("Add wine")
    }
    
    @objc private func editProfileClicked() {
        print("Edit")
    }
    
    @objc private func whatTodoClicked() {
        print("What?")
    }
    
    private func setButtons() {
        wineRequest.button.addTarget(self, action: #selector(addWineClicked), for: .touchUpInside)
        wineRequest.button.addTarget(self, action: #selector(editProfileClicked), for: .touchUpInside)
        wineRequest.button.addTarget(self, action: #selector(whatTodoClicked), for: .touchUpInside)
    }
    
}

// View
extension SettingsViewController {
    
    private func configureView() {
        navigationItem.title = "설정"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(appearanceOutline)
        appearanceOutline.addSubview(stackView)
        
        contentView.addSubview(wineRequest)
        contentView.addSubview(editProfile)
        contentView.addSubview(what)
        contentView.addSubview(logoutButton)
        contentView.addSubview(withdrawButton)
         
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
         
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        appearanceOutline.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(50)
        }
        
        wineRequest.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(60)
        }
        
        editProfile.snp.makeConstraints { make in
            make.top.equalTo(wineRequest.snp.bottom).offset(-1.5)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(60)
        }
        
        what.snp.makeConstraints { make in
            make.top.equalTo(editProfile.snp.bottom).offset(-1.5)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(60)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(what.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(50)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(30)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
