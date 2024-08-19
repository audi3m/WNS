//
//  MainPostViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainPostViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        return view
    }()
    
    
    let viewModel = MainPostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
    
}

// Rx
extension MainPostViewController {
    
    private func rxBind() {
        
        let input = MainPostViewModel.Input()
        let output = viewModel.transform(input: input)
        
        
        
    }
}

// Functions
extension MainPostViewController {
    @objc private func profileButtonClicked() { 
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func commentsButtonClicked() {
        let vc = CommentsViewController()
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
}

// View
extension MainPostViewController {
    
    private func configureView() {
        navigationItem.title = "포스트"
        
        let profile = UIBarButtonItem(image: UIImage(systemName: "person.circle"),
                                      style: .plain, target: self,
                                      action: #selector(profileButtonClicked))
        
        let comments = UIBarButtonItem(image: UIImage(systemName: "bubble"),
                                       style: .plain, target: self,
                                       action: #selector(commentsButtonClicked))
        
        navigationItem.rightBarButtonItem = profile
        navigationItem.leftBarButtonItem = comments
        
        
    }
    
    
}
