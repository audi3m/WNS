//
//  HorizontalScrollViewController.swift
//  WNS
//
//  Created by J Oh on 8/24/24.
//

import UIKit
import SnapKit

final class HorizontalScrollViewController: BaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout())
        view.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        view.showsHorizontalScrollIndicator = false
        view.register(NewPostImageCell.self, forCellWithReuseIdentifier: NewPostImageCell.id)
        view.delegate = self
        view.dataSource = self
        return view
    }()
     
    var list: [UIImage?] = [
        UIImage(named: "wine1"),
        UIImage(named: "wine2"),
        UIImage(named: "wine3"),
        UIImage(named: "wine4"),
        UIImage(named: "wine5")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
}

extension HorizontalScrollViewController {
    
    private func configureView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
    }
    
}

extension HorizontalScrollViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewPostImageCell.id, for: indexPath) as! NewPostImageCell
        let data = list[indexPath.item]
        cell.imageView.image = data
        cell.deleteButton.tag = indexPath.item
        cell.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        return cell
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        return layout
    }
        
    @objc func deleteItem(_ sender: UIButton) {
        let tag = sender.tag
        list.remove(at: tag)
        collectionView.reloadData()
    }
    
}

extension HorizontalScrollViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}
