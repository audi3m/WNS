//
//  MyInquiryViewController.swift
//  WNS
//
//  Created by J Oh on 9/2/24.
//

import UIKit
import SnapKit

final class MyInquiryViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.register(InquiryCell.self, forCellReuseIdentifier: InquiryCell.id)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var inquiryList: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        getMyInquiry()
    }
}

extension MyInquiryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        inquiryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: InquiryCell.id, for: indexPath) as? InquiryCell {
            let post = inquiryList[indexPath.row]
            cell.setData(post: post)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let inquiry = inquiryList[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, success in
            self?.inquiryList.remove(at: indexPath.row)
            PostNetworkManager.shared.deletePost(postID: inquiry.postID) { [weak self] response in
                guard let self else { return }
                switch response {
                case .success:
                    success(true)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

extension MyInquiryViewController {
    
    private func getMyInquiry() {
        let query = GetAllPostQuery(next: "", limit: "100", productID: ProductID.forInquiry.rawValue)
        PostNetworkManager.shared.getUserPosts(userID: AccountManager.shared.userID, query: query) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let success):
                self.inquiryList = success.data
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
    
    @objc private func showRequestSheet() {
        let vc = InquiryViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
}

extension MyInquiryViewController {
    
    private func configureNavBar() {
        navigationItem.title = "1:1 문의"
        let request = UIBarButtonItem(title: "문의하기", image: nil, target: self, action: #selector(showRequestSheet))
        
        navigationItem.rightBarButtonItem = request
        
    }
    private func configureView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

