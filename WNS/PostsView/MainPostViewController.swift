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
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        view.delegate = self
        view.dataSource = self
        view.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        return view
    }()
    lazy var addNewButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonImage.postButton, for: .normal)
        button.addTarget(self, action: #selector(writePost), for: .touchUpInside)
        return button
    }()
    
    let viewModel = MainPostViewModel()
    var list = [Post]()
    var nextCursor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureView()
        rxBind()
        callPosts()
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

extension MainPostViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
//        for item in indexPaths {
//            if item.row == list.count - 2 {
//                start += 30
//                if start <= totalItems {
//                    requestItems()
//                }
//            }
//        }
        
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
    
    @objc private func writePost() {
        let vc = NewPostViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func refreshToken() {
        NetworkManager.shared.refreshAccessToken {
            self.view.makeToast("Refresh Success", position: .top)
        }
    }
    
    @objc private func callPosts() {
        let getAllPostsQuery = GetAllPostQuery(next: "", limit: "5", productID: ProductID.forUsers.rawValue)
        NetworkManager.shared.getAllPosts(query: getAllPostsQuery) { [weak self] response in
            self?.list = response.data
            self?.nextCursor = response.nextCursor
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
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
    
    @objc private func viewProfile() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
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
        let profile = UIBarButtonItem(image: UIImage(systemName: "person.fill"),
                                       style: .plain, target: self,
                                       action: #selector(viewProfile))
        
        navigationItem.leftBarButtonItems = [login, refreshToken]
        navigationItem.rightBarButtonItems = [profile, callPosts]
        
    }
}

// View
extension MainPostViewController {
    
    private func configureView() {
        view.addSubview(tableView)
        view.addSubview(addNewButton)
        
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
        
        addNewButton.snp.makeConstraints { make in
            make.trailing.equalTo(view).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(50)
        }
    }
    
}


