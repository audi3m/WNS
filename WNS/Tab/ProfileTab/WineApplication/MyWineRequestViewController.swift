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
    
    var list: [Post] = [] {
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
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WineRequestCell.id, for: indexPath) as? WineRequestCell {
            let post = list[indexPath.row]
            cell.setData(post: post)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}

extension MyWineRequestViewController {
    
    private func getMyRequest() {
        let query = GetAllPostQuery(next: "", limit: "100", productID: ProductID.forWineRequest.rawValue)
        NetworkManager.shared.getUserPosts(userID: AccountManager.shared.userID, query: query) { [weak self] response in
            guard let self else { return }
            self.list = response.data
            print(list)
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
        navigationItem.title = "와인 리스트 신청"
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

