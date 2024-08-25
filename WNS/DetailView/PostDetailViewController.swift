//
//  PostDetailViewController.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class PostDetailViewController: BaseViewController {
    
    let profileView: ProfileAndNicknameView = {
        let view = ProfileAndNicknameView()
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout())
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.register(PostImageCollectionViewCell.self, forCellWithReuseIdentifier: PostImageCollectionViewCell.id)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.numberOfPages = post.files.count
        control.hidesForSinglePage = true
        control.currentPageIndicatorTintColor = .systemBlue
        control.pageIndicatorTintColor = .lightGray
        return control
    }()
    
    let post: Post
    var like: Bool?
    
    var images = [String]()
    let viewModel = DetailViewModel()

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        configureData(post: post)
        rxBind()
    }
    
}

// Rx
extension PostDetailViewController {
    private func rxBind() { }
}

// Functions
extension PostDetailViewController {
    @objc private func likeButtonTapped() {
        
    }
}

// View
extension PostDetailViewController {
    
    private func configureNavBar() {
        navigationItem.title = "상세화면"
        let image = post.likeThisPost ? ButtonImage.heartFill : ButtonImage.heart
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(likeButtonTapped))
        navigationItem.rightBarButtonItems = [item]
    }
    
    private func configureView() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.centerX.equalTo(collectionView.snp.centerX)
            make.height.equalTo(30)
        }
    }
    
    private func configureData(post: Post) {
        
        profileView.setProfile(creator: post.creator)
        images = post.files
        print(images)
        
        
        like = post.likeThisPost
        
        
    }
}

// Collection View
extension PostDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostImageCollectionViewCell.id, for: indexPath) as? PostImageCollectionViewCell else { return UICollectionViewCell() }
        let fileURL = images[indexPath.item]
        cell.setImage(fileURL: fileURL)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 250)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }
    
}
