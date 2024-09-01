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
    
    var list: [Post] = [] {
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
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: InquiryCell.id, for: indexPath) as? InquiryCell {
            let post = list[indexPath.row]
            cell.setData(post: post)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}

extension MyInquiryViewController {
    
    private func getMyInquiry() {
        let query = GetAllPostQuery(next: "", limit: "100", productID: ProductID.forInquiry.rawValue)
        NetworkManager.shared.getUserPosts(userID: AccountManager.shared.userID, query: query) { [weak self] response in
            guard let self else { return }
            self.list = response.data
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

