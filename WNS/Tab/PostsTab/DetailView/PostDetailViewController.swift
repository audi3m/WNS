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
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let profileView = ProfileAndNicknameView()
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
        control.hidesForSinglePage = true
        control.backgroundStyle = .prominent
        control.contentScaleFactor = 0.5
        control.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return control
    }()
    let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let postID: String
    var like: Bool?
    var images = [String]()
    let viewModel = DetailViewModel()

    init(postID: String) {
        self.postID = postID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        NetworkManager.shared.getSomePost(postID: postID) { [weak self] post in
            guard let self else { return }
            self.configureNavBar(post: post)
            self.configureData(post: post)
            self.pageControl.numberOfPages = post.files.count
            self.configureWine(wineInJSON: post.content1)
        }
        
        rxBind()
    }
}

// Rx
extension PostDetailViewController {
    private func rxBind() { }
}

// Functions
extension PostDetailViewController {
    
    @objc func commentsButtonTapped() {
        let vc = CommentsViewController(postID: postID)
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    @objc func likeButtonTapped() {
        guard var like else { return }
        like = !like
        setLikeButton(like: like)
        let body = LikeBody(like_status: like)
        
        NetworkManager.shared.like(postID: postID, body: body) { response in
            DispatchQueue.main.async {
                let like = response.likeStatus
                self.setLikeButton(like: like)
            }
        }
    }
    
    private func setLikeButton(like: Bool) {
        let image = like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        navigationItem.rightBarButtonItem?.image = image
        navigationItem.rightBarButtonItem?.tintColor = like ? .systemPink : .label
    }
}

// View
extension PostDetailViewController {
    
    private func configureWine(wineInJSON: String?) {
        if let wineInJSON {
            let wine = Wine.fromJsonString(wineInJSON)
            
        } else {
            
        }
    }
    
    private func configureNavBar(post: Post) {
        navigationItem.title = "상세화면"
        let image = post.likeThisPost ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(likeButtonTapped))
        item.tintColor = post.likeThisPost ? .systemPink : .label
        
        let comments = UIBarButtonItem(image: UIImage(systemName: "bubble"), style: .plain, target: self, action: #selector(commentsButtonTapped))
        comments.tintColor = .label
        navigationItem.rightBarButtonItems = [comments, item]
    }
    
    private func configureView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileView)
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(colorView)
        
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(350)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(30)
        }
        
        colorView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(100)
            make.height.equalTo(1000)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureData(post: Post) {
        profileView.setProfile(creator: post.creator)
        images = post.files
        like = post.likeThisPost
        collectionView.reloadData()
    }
    
}

// CollectionView
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
        let pageWidth = collectionView.frame.width
        let page = scrollView.contentOffset.x / pageWidth
        pageControl.currentPage = Int(round(page))
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 350)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }
    
}
