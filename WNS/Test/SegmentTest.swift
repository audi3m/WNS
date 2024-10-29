//
//  SegmentTest.swift
//  WNS
//
//  Created by J Oh on 9/1/24.
//

import UIKit
import SnapKit

enum SearchBy {
    case wine, hashtag, user
}

final class SegmentedTableViewController: BaseViewController {
    
    lazy var segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["와인", "해시태그", "닉네임"])
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        return view
    }()
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "와인, 해시태그, 닉네임을 검색해보세요"
        view.backgroundImage = UIImage()
        view.delegate = self
        return view
    }()
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(SearchPostsCell.self, forCellReuseIdentifier: SearchPostsCell.id)
        return view
    }()
    let noResultsLabel = UILabel()
    
    var wineList = [Post]()
    var hashList = [Post]()
    var userList = [Creator]()
    
    var currentData = [Post]()
    var searchBy = SearchBy.wine {
        didSet {
            switch searchBy {
            case .wine:
                currentData = wineList
            case .hashtag:
                currentData = hashList
            case .user:
                currentData = wineList
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        currentData = wineList
    }
}

// View
extension SegmentedTableViewController {
    
    func configureView() {
        navigationItem.title = "게시물 검색"
        view.addSubview(searchBar)
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            searchBy = .wine
            currentData = wineList
        case 1:
            searchBy = .hashtag
            currentData = hashList
        case 2:
            searchBy = .user
            print("0")
        default:
            break
        }
        tableView.reloadData()
    }
}

extension SegmentedTableViewController {
    
    private func searchByWine(searchText: String) {
        let wineName = HashtagForWineSearch.prefix.dropFirst() + searchText.replacingOccurrences(of: " ", with: "")
        let query = HashQuery(next: "", limit: "100", productID: ProductID.forUsers.rawValue, hashTag: String(wineName))
        SearchNetworkManager.shared.searchHashtag(query: query) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let success):
                self.wineList = success.data
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func searchByHashtag(searchText: String) {
        let query = HashQuery(next: "", limit: "100", productID: ProductID.forUsers.rawValue, hashTag: searchText)
        SearchNetworkManager.shared.searchHashtag(query: query) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let success):
                self.hashList = success.data
            case .failure(let failure):
                print(failure)
            }
        }

    }
    
    private func searchByUser() {
        
    }
}

extension SegmentedTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            searchByWine(searchText: searchText)
            searchByHashtag(searchText: searchText)
            switch searchBy {
            case .wine:
                currentData = wineList
            case .hashtag:
                currentData = hashList
            case .user:
                print("To be updated")
            }
            
        }
    }
}

extension SegmentedTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = currentData[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchPostsCell.id, for: indexPath) as? SearchPostsCell {
            cell.configureData(data: data)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let postID = currentData[indexPath.row].postID
        let vc = PostDetailViewController(postID: postID)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
        
    }
}
