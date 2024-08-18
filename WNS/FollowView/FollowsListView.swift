//
//  FollowsListView.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import UIKit
import SnapKit

final class FollowsListView: UIView {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.register(FollowsTableViewCell.self, forCellReuseIdentifier: FollowsTableViewCell.id)
        return view
    }()
    
    func configureView() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
    }
    
    
    
}
