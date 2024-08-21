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
    var list = [Post]()
    
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
    
    @objc private func commentsButtonClicked() {
        let vc = CommentsViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }
    
    @objc private func refreshToken() {
        NetworkManager.shared.refreshAccessToken {
            
        } onFail: { message in
            print(message)
        }
    }
    
    @objc private func callPosts() {
        let query = GetAllPostQuery(next: "", limit: "10", productID: "WNS_user")
        NetworkManager.shared.getAllPosts(query: query) { response in
            self.list = response.data
            self.tableView.reloadData()
        }
    }
    
    @objc private func login() {
        
        let login = LoginBody(email: "c@c.com", password: "cccc")
        NetworkManager.shared.login(body: login) { response in
            print("Login Success")
            LoginManager.shared.access = response.accessToken
            LoginManager.shared.refresh = response.refreshToken
            LoginManager.shared.userID = response.userID
            
        } failHandler: { message in
            print(message)
        }

    }
    
    
}

// Nav
extension MainPostViewController {
    
    private func configureView() {
        navigationItem.title = "게시물"
        
        let login = UIBarButtonItem(image: UIImage(systemName: "arrow.right.square"),
                                    style: .plain, target: self,
                                    action: #selector(login))
        let refreshToken = UIBarButtonItem(image: UIImage(systemName: "arrow.left.arrow.right.square"),
                                    style: .plain, target: self,
                                    action: #selector(refreshToken))
        let callPosts = UIBarButtonItem(image: UIImage(systemName: "arrow.circlepath"),
                                       style: .plain, target: self,
                                       action: #selector(callPosts))
        let comments = UIBarButtonItem(image: UIImage(systemName: "bubble"),
                                       style: .plain, target: self,
                                       action: #selector(commentsButtonClicked))
        
        navigationItem.leftBarButtonItems = [login, refreshToken]
        navigationItem.rightBarButtonItems = [callPosts, comments]
        
    }
}

// View
extension MainPostViewController {
    
    
    
    
}
