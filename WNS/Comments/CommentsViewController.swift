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
        view.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.id)
        return view
    }()
    let commentField: CommentTextFieldView = {
        let view = CommentTextFieldView()
        
        return view
    }()
    
    let viewModel = CommentsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        rxBind()
    }
    
     
    
}

// Rx
extension CommentsViewController {
    
    private func rxBind() {
        
        let input = CommentsViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.commentsList
            .drive(tableView.rx.items(cellIdentifier: CommentTableViewCell.id, cellType: CommentTableViewCell.self)) { (row, element, cell) in
                
            }
            .disposed(by: disposeBag)
        
    }
    
}

extension CommentsViewController {
    
    private func configureView() { 
        navigationItem.title = "댓글"
        
        view.addSubview(tableView)
        view.addSubview(commentField)
        
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        commentField.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        
    }
    
    
    
}
