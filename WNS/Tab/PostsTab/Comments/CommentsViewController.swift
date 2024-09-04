//
//  CommentsViewController.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift
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
    let emptyView: EmptyView = {
        let view = EmptyView(type: .comments)
        return view
    }()
    lazy var commentField: CommentTextFieldView = {
        let view = CommentTextFieldView()
        view.textField.delegate = self
        view.sendButton.addTarget(self, action: #selector(writeComment), for: .touchUpInside)
        return view
    }()
    
    let postID: String
    let viewModel = CommentsViewModel()
    let disposeBag = DisposeBag()
    var list = [Comment]() {
        didSet {
            if list.isEmpty {
                emptyView.isHidden = false
                tableView.isHidden = true
            } else {
                emptyView.isHidden = true
                tableView.isHidden = false
            }
            tableView.reloadData()
        }
    }
    
    var commentsBottomConstraint: Constraint?
    var emptyBottomConstraint: Constraint?
    
    init(postID: String) {
        self.postID = postID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getComments(postID: postID)
        configureView()
        rxBind()
        
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
    }
    
}

// Functions
extension CommentsViewController {
    
    func getComments(postID: String) {
        NetworkManager.shared.getSomePost(postID: postID) { [weak self] post in
            self?.list = post.comments
        }
    }
    
    @objc private func writeComment() {
        guard let comment = commentField.textField.text else { return }
        guard !comment.isEmpty else { return }
        
        let commentBody = CommentBody(content: comment)
        NetworkManager.shared.writeComment(postID: postID, body: commentBody) { response in
            print(response)
            self.commentField.textField.text = ""
            self.getComments(postID: self.postID)
        }
        view.endEditing(true)
    }
}

// Rx
extension CommentsViewController {
    private func rxBind() { }
}

// TextField
extension CommentsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let comment = commentField.textField.text else { return false }
        guard !comment.isEmpty else { return false }
        
        let commentBody = CommentBody(content: comment)
        NetworkManager.shared.writeComment(postID: postID, body: commentBody) { response in
            self.commentField.textField.text = ""
            self.getComments(postID: self.postID)
        }
        
        view.endEditing(true)
        return true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
           let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
           let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            commentsBottomConstraint?.update(offset: -keyboardHeight + 10)
            
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: animationCurve << 16),
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
           let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            
            self.commentsBottomConstraint?.update(offset: -10)
            
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: animationCurve << 16),
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
//    @objc func keyboardWillShow(_ notification: Notification) {
//        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardHeight = keyboardFrame.cgRectValue.height
//            commentsBottomConstraint?.update(offset: -keyboardHeight)
//        }
//    }
//    
//    @objc func keyboardWillHide(_ notification: Notification) {
//        commentsBottomConstraint?.update(offset: -10)
//    }
    
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
        view.addSubview(emptyView)
        view.addSubview(commentField)
        
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(commentField.snp.top)
        }
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        commentField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            commentsBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10).constraint
            make.height.equalTo(50)
        }
    }
}
 
  
