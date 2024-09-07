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
        view.backgroundColor = .systemGray6
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        view.delegate = self
        view.dataSource = self
        view.prefetchDataSource = self
        view.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        return view
    }()
    
    let viewModel = MainPostViewModel()
    var list = [Post]()
    var nextCursor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        login()
        rxBind()
        
        print(AccountManager.shared.profile ?? "")
    }
    
}

// Delegate
extension MainPostViewController: PostCellDelegate {
    func commentsButtonTapped(in cell: UITableViewCell, postID: String) {
        let vc = CommentsViewController(postID: postID)
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
}

extension MainPostViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == list.count - 2 {
                if nextCursor != "0" {
                    callPosts(next: nextCursor)
                }
            }
        }
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
        cell.like = data.likes.contains(AccountManager.shared.userID)
        cell.delegate = self 
        cell.configureImagesByCount() 
        cell.configureData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postID = list[indexPath.row].postID
        let vc = PostDetailViewController(postID: postID) 
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true) 
    }
}

// Rx
extension MainPostViewController {
    private func rxBind() { }
}

// Network Functions
extension MainPostViewController {
    
    @objc private func writePost() {
        let vc = NewPostViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func wrongToken() {
        AccountManager.shared.access = "hi"
    }
    
    private func callPosts(next: String = "") {
        let getAllPostsQuery = GetAllPostQuery(next: next, limit: "5", productID: ProductID.forUsers.rawValue)
        PostNetworkManager.shared.getAllPosts(query: getAllPostsQuery) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let success):
                DispatchQueue.main.async {
                    if next.isEmpty {
                        self.list = success.data
                        self.tableView.reloadData()
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    } else {
                        self.list.append(contentsOf: success.data)
                        self.tableView.reloadData()
                    }
                }
                self.nextCursor = success.nextCursor
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    @objc private func login() {
        let login = LoginBody(email: "admin@admin.admin", password: "adminadmin")
        AccountNetworkManager.shared.login(body: login) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let success):
                self.view.makeToast("Login Success", position: .top)
                callPosts()
            case .failure(let failure):
                self.showAlert(title: "", message: failure.localizedDescription, ok: "확인") { }
            }
        }
    }
    
    @objc private func refreshPosts() {
        nextCursor = ""
        callPosts()
    }
     
}

// View
extension MainPostViewController {
    
    private func configureNavBar() {
        navigationItem.title = "게시물"
        
        let login = UIBarButtonItem(image: ButtonImage.navLogin, style: .plain, target: self, action: #selector(login))
        let wrongToken = UIBarButtonItem(image: ButtonImage.navRefresh, style: .plain, target: self, action: #selector(wrongToken))
        let callPost = UIBarButtonItem(title: "불러오기", style: .plain, target: self, action: #selector(callPostssss))
        
        navigationItem.leftBarButtonItems = [login, wrongToken]
        navigationItem.rightBarButtonItem = callPost

    }
    
    private func configureView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func callPostssss() {
        callPosts()
    }
}

