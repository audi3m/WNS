//
//  EditProfileViewController.swift
//  WNS
//
//  Created by J Oh on 9/2/24.
//
 
import UIKit
import SnapKit

final class EditProfileViewController: BaseViewController {
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    let nicknameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

extension EditProfileViewController {
    private func configureView() {
        navigationItem.title = "프로필 수정"
        view.addSubview(profileImageView)
        view.addSubview(nicknameLabel)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
        }
        
        if let profile = AccountManager.shared.profile {
            profileImageView.setImageWithURL(with: profile)
        }
        
    }
}
