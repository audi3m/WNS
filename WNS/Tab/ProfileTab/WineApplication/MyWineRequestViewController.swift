//
//  MyWineRequestViewController.swift
//  WNS
//
//  Created by J Oh on 9/2/24.
//

import UIKit
import SnapKit

final class MyWineRequestViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.register(WineRequestCell.self, forCellReuseIdentifier: WineRequestCell.id)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var requestList: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        getMyRequest()
    }
    
}

extension MyWineRequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        requestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WineRequestCell.id, for: indexPath) as? WineRequestCell {
            let post = requestList[indexPath.row]
            cell.setData(post: post)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let request = requestList[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, success in
            self?.requestList.remove(at: indexPath.row)
            PostNetworkManager.shared.deletePost(postID: request.postID) {
                success(true)
            }
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

extension MyWineRequestViewController {
    
    private func getMyRequest() {
        let query = GetAllPostQuery(next: "", limit: "100", productID: ProductID.forWineRequest.rawValue)
        PostNetworkManager.shared.getUserPosts(userID: AccountManager.shared.userID, query: query) { [weak self] response in
            guard let self else { return }
            self.requestList = response.data
        }
    }
    
    @objc private func showRequestSheet() {
        let vc = WineRequestViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
     
}

extension MyWineRequestViewController {
    
    private func configureNavBar() {
        navigationItem.title = "와인 리스트 추가"
        let request = UIBarButtonItem(title: "신청하기", image: nil, target: self, action: #selector(showRequestSheet))
        
        navigationItem.rightBarButtonItem = request
        
        
        
    }
    private func configureView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

