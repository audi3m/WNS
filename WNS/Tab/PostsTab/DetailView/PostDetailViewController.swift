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
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    let contentView = UIView()
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
        control.currentPageIndicatorTintColor = .redWine
        control.backgroundStyle = .prominent
        control.contentScaleFactor = 0.5
        control.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return control
    }()
    let profileView = ProfileAndNicknameView()
    let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = DesignSize.fieldCornerRadius
        button.backgroundColor = .systemBlue
        return button
    }()
    let postSection = PostSectionView()
    let commentsSection = CommentsSectionView()
    let wineSection = WineSectionView()
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonImage.closeButton, for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
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
        callPost()
        rxBind()
    }
}

// Rx
extension PostDetailViewController {
    private func rxBind() { }
}

// Functions
extension PostDetailViewController {
    
    private func follow(userID: String) {
        
        LikeNetworkManager.shared.follow(userID: userID) { response in
            switch response {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func unFollow(userID: String) {
        
        LikeNetworkManager.shared.unFollow(userID: userID) { response in
            switch response {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    @objc private func followTapped(userID: String) {
        
    }
    
    private func callPost() {
        PostNetworkManager.shared.getSomePost(postID: postID) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let post):
                self.configureData(post: post)
                self.pageControl.numberOfPages = post.files.count
                self.postSection.setData(post: post)
                self.configureWine(wineInJSON: post.content1)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
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
        
        LikeNetworkManager.shared.like(postID: postID, body: body) { response in
            switch response {
            case .success(let success):
                DispatchQueue.main.async {
                    let like = success.likeStatus
                    self.setLikeButton(like: like)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    @objc private func commentClicked() {
        let vc = CommentsViewController(postID: postID)
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
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
        if let wineInJSON, let wine = Wine.fromJsonString(wineInJSON) {
            wineSection.setData(wine: wine)
        }
    }
    
    private func configureView() {
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(profileView)
        contentView.addSubview(followButton)
        contentView.addSubview(postSection)
        contentView.addSubview(commentsSection)
        contentView.addSubview(wineSection)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(350)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(30)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalTo(followButton.snp.leading).offset(-DesignSize.fieldPadding)
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileView)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        postSection.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        commentsSection.snp.makeConstraints { make in
            make.top.equalTo(postSection.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        wineSection.snp.makeConstraints { make in
            make.top.equalTo(commentsSection.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-130)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(60)
        }
        
        let commentGesture = UITapGestureRecognizer(target: self, action: #selector(commentClicked))
        commentsSection.addGestureRecognizer(commentGesture)
        
    }
    
    private func configureData(post: Post) {
        profileView.setProfile(creator: post.creator)
        images = post.files
        like = post.likeThisPost
        collectionView.reloadData()
        commentsSection.setComments(comments: post.comments)
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
