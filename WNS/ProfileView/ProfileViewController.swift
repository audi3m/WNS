//
//  ProfileViewController.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// id, email, nick, phone, birthday, profile, followers, following, posts
final class ProfileViewController: BaseViewController {
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let nicknameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let phoneLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let birthdayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
    
    
}

// Rx
extension ProfileViewController {
    
    private func rxBind() {
        
        let input = ProfileViewModel.Input()
        let output = viewModel.transform(input: input)
            
    }
    
}

// View
extension ProfileViewController {
    
    private func configureView() { 
        navigationItem.title = "내 프로필"
        
        view.addSubview(profileImageView)
        view.addSubview(emailLabel)
        view.addSubview(nicknameLabel)
        view.addSubview(phoneLabel)
        view.addSubview(birthdayLabel) 
        
        profileImageView.snp.makeConstraints { make in
            
        }
        
        emailLabel.snp.makeConstraints { make in
            
        }
        
        nicknameLabel.snp.makeConstraints { make in
            
        }
        
        phoneLabel.snp.makeConstraints { make in
            
        }
        
        birthdayLabel.snp.makeConstraints { make in
            
        }
        
        
        
        
        
    }
    
    
    
}
