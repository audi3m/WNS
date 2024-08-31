//
//  HashtagViewController.swift
//  WNS
//
//  Created by J Oh on 8/31/24.
//

import UIKit
import SnapKit
import TagListView

final class HashtagViewController: BaseViewController {
    
    lazy var hashField: OutlineField = {
        let view = OutlineField(fieldType: .hashtag, cornerType: .all)
        view.textField.placeholder = "공백 없이 입력 후 엔터"
        view.textField.delegate = self
        return view
    }()
    lazy var hashtagListView: CustomTagListView = {
        let view = CustomTagListView()
        view.textFont = UIFont.systemFont(ofSize: 18)
        view.tagBackgroundColor = .systemGray6
        view.textColor = .label
        view.cornerRadius = 8
        view.delegate = self
        return view
    }()
    
    var hashList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

extension HashtagViewController: TagListViewDelegate {
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        sender.removeTagView(tagView)
    }
}

extension HashtagViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let hash = hashField.textField.text else { return false }
        if !hash.isEmpty {
            let hashView = hashtagListView.addTag("#" + hash) 
            hashField.textField.text = ""
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.contains(" ") ? false : true
    }
    
    func getAllTagsText() -> String {
        let allTagsArray = hashtagListView.tagViews.compactMap { $0.titleLabel?.text }
        return allTagsArray.joined(separator: " ")
    }
}

extension HashtagViewController {
    private func configureView() {
        navigationItem.title = "해시태그"
        
        view.addSubview(hashField)
        view.addSubview(hashtagListView)
        
        hashField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
            make.height.equalTo(50)
        }
        hashtagListView.snp.makeConstraints { make in
            make.top.equalTo(hashField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(DesignSize.fieldHorizontalPadding)
        }
    }
}
