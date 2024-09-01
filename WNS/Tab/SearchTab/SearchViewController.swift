//
//  SearchViewController.swift
//  WNS
//
//  Created by J Oh on 8/26/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "와인, 해시태그, 닉네임을 검색해보세요"
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        rxBind()
    }
    
}

// Rx
extension SearchViewController {
    private func rxBind() { }
}

// Functions
extension PostDetailViewController {
    
    
    
    
}

// View
extension SearchViewController {
    
    private func configureNavBar() {
        navigationItem.title = "검색"
        
        
    }
    
    private func configureView() {
        
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        
    }
     
}
 
