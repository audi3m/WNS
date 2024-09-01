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
        view.layer.cornerRadius = DesignSize.fieldCornerRadius
        view.layer.borderWidth = DesignSize.outlineWidth
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
    
    private let editProfile = OutlineButton(name: "프로필 수정", cornerType: .top)
    private let wineRequest = OutlineButton(name: "와인 추가 신청", cornerType: .middle)
    private let inquiry = OutlineButton(name: "1:1 문의", cornerType: .bottom)
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = DesignSize.fieldCornerRadius
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
        let vc = WineRequestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func editProfileClicked() {
        print("Edit")
    }
    
    @objc private func inquiryClicked() {
        let vc = InquiryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func logoutClicked() {
        showAlertWithChoice(title: "로그아웃", message: "정말로 로그아웃하시겠습니까?", ok: "확인") {
            AccountManager.shared.resetAccount()
            self.resetRootViewController(root: LoginViewController(), withNav: true)
        } 
    }
    
    @objc private func withdrawClicked() {
        print(#function)
        showAlertWithChoice(title: "회원탈퇴", message: "정말로 탈퇴하시겠습니까?", ok: "확인") {
            self.showAlertForReal(title: "회원탈퇴", message: "탈퇴하면 모든 정보가 사라집니다", ok: "확인") {
                NetworkManager.shared.withdraw { response in
                    self.showAlert(title: "", message: "탈퇴되었습니다", ok: "확인") {
                        self.resetRootViewController(root: LoginViewController(), withNav: true)
                    }
                }
            }
        }
    }
    
    @objc private func goToAdminPage() {
        let vc = AdminViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setButtons() {
        editProfile.button.addTarget(self, action: #selector(editProfileClicked), for: .touchUpInside)
        wineRequest.button.addTarget(self, action: #selector(addWineClicked), for: .touchUpInside)
        inquiry.button.addTarget(self, action: #selector(inquiryClicked), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutClicked), for: .touchUpInside)
        withdrawButton.addTarget(self, action: #selector(withdrawClicked), for: .touchUpInside)
    }
}

// View
extension SettingsViewController {
    
    private func configureView() {
        navigationItem.title = "설정"
        
        if AccountManager.shared.isAdmin {
            let admin = UIBarButtonItem(image: UIImage(systemName: "person.badge.key"),
                                       style: .plain, target: self,
                                       action: #selector(goToAdminPage))
            navigationItem.rightBarButtonItem = admin
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(appearanceOutline)
        appearanceOutline.addSubview(stackView)
        
        contentView.addSubview(wineRequest)
        contentView.addSubview(editProfile)
        contentView.addSubview(inquiry)
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
            make.horizontalEdges.equalTo(contentView).inset(30)
            make.height.equalTo(100)
        }
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
        }
        editProfile.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        wineRequest.snp.makeConstraints { make in
            make.top.equalTo(editProfile.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(contentView).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        inquiry.snp.makeConstraints { make in
            make.top.equalTo(wineRequest.snp.bottom).offset(-DesignSize.outlineWidth)
            make.horizontalEdges.equalTo(contentView).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(inquiry.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(30)
            make.height.equalTo(DesignSize.fieldHeight)
        }
        withdrawButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(30)
            make.height.equalTo(30)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
        }
    }
}
