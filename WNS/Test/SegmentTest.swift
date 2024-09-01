//
//  SegmentTest.swift
//  WNS
//
//  Created by J Oh on 9/1/24.
//

import UIKit
import SnapKit

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
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    let noResultsLabel = UILabel()
    
    let firstData = ["Apple", "Banana", "Cherry"]
    let secondData = ["Dog", "Cat", "Rabbit"]
    let thirdData = [String]()
    
    var currentData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupNoResultsLabel()
        
        currentData = firstData
        updateNoResultsLabel()
    }
}

// View
extension SegmentedTableViewController {
    
    func configureView() {
        navigationItem.title = "게시물 검색"
        view.addSubview(segmentedControl)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNoResultsLabel() {
        noResultsLabel.text = "검색결과가 없습니다."
        noResultsLabel.textAlignment = .center
        noResultsLabel.textColor = .gray
        noResultsLabel.font = UIFont.systemFont(ofSize: 18)
        noResultsLabel.isHidden = true
        
        view.addSubview(noResultsLabel)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentData = firstData
        case 1:
            currentData = secondData
        case 2:
            currentData = thirdData
        default:
            break
        }
        tableView.reloadData()
        updateNoResultsLabel()
    }
    
    func updateNoResultsLabel() {
        noResultsLabel.isHidden = !currentData.isEmpty
    }
}

extension SegmentedTableViewController: UISearchBarDelegate {
    
}

extension SegmentedTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(currentData[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
