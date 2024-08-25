//
//  HorizontalScrollView.swift
//  WNS
//
//  Created by J Oh on 8/23/24.
//

import UIKit
import SnapKit

final class HorizontalScrollView: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: layout())
        view.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        return view
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, SelectedItem>! = nil
    let list: [SelectedItem] = [
        SelectedItem(image: UIImage(named: "wine1")),
        SelectedItem(image: UIImage(named: "wine2")),
        SelectedItem(image: UIImage(named: "wine3")),
        SelectedItem(image: UIImage(named: "wine4")),
        SelectedItem(image: UIImage(named: "wine5"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Orthogonal Sections"
        configureDataSource()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
    }
}

extension HorizontalScrollView {
    
    func layout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        return layout
    }
}

extension HorizontalScrollView {
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<NewPostImageCell, SelectedItem> { (cell, indexPath, identifier) in
            cell.imageView.image = identifier.image
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, SelectedItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: SelectedItem) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, SelectedItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension HorizontalScrollView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HorizontalScrollView {
    enum Section {
        case main
    }
    
    struct SelectedItem: Hashable {
        let image: UIImage?
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
}
