//
//  CommentsViewController.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CommentsViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.id)
        return view
    }()
    lazy var commentField: CommentTextFieldView = {
        let view = CommentTextFieldView()
        view.commentField.delegate = self
        view.sendButton.addTarget(self, action: #selector(writeComment), for: .touchUpInside)
        return view
    }()
    
    let postID: String
    let viewModel = CommentsViewModel()
    let disposeBag = DisposeBag()
    var list = [Comment]()
    
    init(postID: String) {
        self.postID = postID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        getComments(postID: postID)
        configureView()
        rxBind()
        
    }
    
}

// Functions
extension CommentsViewController {
    func getComments(postID: String) {
        NetworkManager.shared.getSomePost(postID: postID) { [weak self] post in
            self?.list = post.comments
            self?.tableView.reloadData()
        }
    }
    
    @objc private func writeComment() {
        guard let comment = commentField.commentField.text else { return }
        guard !comment.isEmpty else { return }
        
        let commentBody = CommentBody(content: comment)
        NetworkManager.shared.writeComment(postID: postID, body: commentBody) { response in
            print(response)
            self.commentField.commentField.text = ""
            self.getComments(postID: self.postID)
        }
        view.endEditing(true)
    }
}

// Rx
extension CommentsViewController {
    
    private func rxBind() {
        
        
    }
    
}

extension CommentsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let comment = commentField.commentField.text else { return false }
        guard !comment.isEmpty else { return false }
        
        let commentBody = CommentBody(content: comment)
        NetworkManager.shared.writeComment(postID: postID, body: commentBody) { response in
            print(response)
            self.commentField.commentField.text = ""
            self.getComments(postID: self.postID)
        }
        
        view.endEditing(true)
        return true
    }
    
}

// TableView
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.id, for: indexPath) as! CommentTableViewCell
        let data = list[indexPath.row]
        cell.data = data
        cell.configureData()
        return cell
    }
    
    
}

// View
extension CommentsViewController {
    
    private func configureView() { 
        navigationItem.title = "댓글"
        
        view.addSubview(tableView)
        view.addSubview(commentField)
        
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(commentField.snp.top)
        }
        
        commentField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
        }
        
    }
    
}
