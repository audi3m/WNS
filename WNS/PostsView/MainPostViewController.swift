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
import Toast

final class MainPostViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        return view
    }()
    
    let viewModel = MainPostViewModel()
    var list = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureView()
        rxBind()
    }
    
}

// Delegate
extension MainPostViewController: PostCellDelegate {
    
    func commentsButtonTapped(in cell: UITableViewCell, postID: String) {
        let vc = CommentsViewController(postID: postID)
        let nav = UINavigationController(rootViewController: vc)
        print(#function)
        present(nav, animated: true)
    }
     
}

// TableView
extension MainPostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    // optimistic ui
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as! PostTableViewCell
        let data = list[indexPath.row]
        cell.postData = data
        cell.delegate = self
        cell.like = data.likes.contains(AccountManager.shared.userID)
        cell.configureData()
        return cell
    }
    
}

// Rx
extension MainPostViewController {
    private func rxBind() {
//        let input = MainPostViewModel.Input()
//        let output = viewModel.transform(input: input)
    }
}

// Functions
extension MainPostViewController {
    
    @objc private func refreshToken() {
        NetworkManager.shared.refreshAccessToken {
            self.view.makeToast("Refresh Success", position: .top)
        }
    }
    
    @objc private func callPosts() {
        let getAllPostsQuery = GetAllPostQuery(next: "", limit: "10", productID: ProductID.forUsers.rawValue)
        NetworkManager.shared.getAllPosts(query: getAllPostsQuery) { [weak self] response in
            self?.list = response.data
            self?.tableView.reloadData()
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    @objc private func login() {
        let login = LoginBody(email: "c@c.com", password: "cccc")
        NetworkManager.shared.login(body: login) { response in
            self.view.makeToast("Login Success", position: .top)
            AccountManager.shared.access = response.accessToken
            AccountManager.shared.refresh = response.refreshToken
            AccountManager.shared.userID = response.userID
        } 

    }
     
}

// Nav
extension MainPostViewController {
    
    private func configureNav() {
        navigationItem.title = "게시물"
        
        let login = UIBarButtonItem(image: UIImage(systemName: "arrow.right.square"),
                                    style: .plain, target: self,
                                    action: #selector(login))
        let refreshToken = UIBarButtonItem(image: UIImage(systemName: "arrow.circlepath"),
                                    style: .plain, target: self,
                                    action: #selector(refreshToken))
        let callPosts = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"),
                                       style: .plain, target: self,
                                       action: #selector(callPosts))
        
        navigationItem.leftBarButtonItems = [login, refreshToken]
        navigationItem.rightBarButtonItems = [callPosts]
        
    }
}

// View
extension MainPostViewController {
    
    private func configureView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}


