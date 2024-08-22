////
////  RxComments.swift
////  WNS
////
////  Created by J Oh on 8/22/24.
////
//
//import UIKit
//import SnapKit
//import RxSwift
//import RxCocoa
//
//final class SimpleListViewController: BaseViewController {
//    
//    enum Section {
//        case main
//    }
//    
//    var dataSource: UICollectionViewDiffableDataSource<Section, Comment>! = nil
//    lazy var collectionView: UICollectionView = {
//        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
//        view.delegate = self
//        view.register(CommentCollectionViewListCell.self, forCellWithReuseIdentifier: CommentCollectionViewListCell.id)
//        return view
//    }()
//    
//    let postID: String
//    let viewModel = CommentsViewModel()
//    let disposeBag = DisposeBag()
//
//    let items = BehaviorSubject<[Comment]>(value: [])
//    
//    init(postID: String) {
//        self.postID = postID
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "List"
//        
//        configureView()
//        configureDataSource()
//        rxBind()
//    }
//    
//}
//
//extension SimpleListViewController {
//    private func rxBind() {
//        
//        let input = CommentsViewModel.Input(postID: postID)
//        
//        
//        items
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] newItems in
//                var snapshot = NSDiffableDataSourceSnapshot<Section, Comment>()
//                snapshot.appendSections([.main])
//                snapshot.appendItems(newItems)
//                self?.dataSource.apply(snapshot, animatingDifferences: true)
//            })
//            .disposed(by: disposeBag)
//    }
//
//    func addMoreItems() {
//        let currentItems = (try? items.value()) ?? []
//        let currentMaxIdentifier = currentItems.max() ?? 0
//        let additionalItems = Array(currentMaxIdentifier + 1...currentMaxIdentifier + Int.random(in: 100...200))
//        
//        items.onNext(currentItems + additionalItems)
//    }
//}
//
//// View
//extension SimpleListViewController {
//    private func createLayout() -> UICollectionViewLayout {
//        let config = UICollectionLayoutListConfiguration(appearance: .plain)
//        return UICollectionViewCompositionalLayout.list(using: config)
//    }
//    
//    private func configureView() {
//        view.addSubview(collectionView)
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//}
//
//// CollectionView
//extension SimpleListViewController: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//    }
//    
//    private func configureDataSource() {
//        let cellRegistration = UICollectionView.CellRegistration<CommentCollectionViewListCell, Comment> { (cell, indexPath, item) in
//            var content = cell.defaultContentConfiguration()
//            content.text = "\(item)"
//            cell.contentConfiguration = content
//        }
//        
//        dataSource = UICollectionViewDiffableDataSource<Section, Comment>(collectionView: collectionView) {
//            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Comment) -> UICollectionViewCell? in
//            
//            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
//        }
//    }
//}
