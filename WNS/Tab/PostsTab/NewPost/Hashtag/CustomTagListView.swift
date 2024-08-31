//
//  CustomTagListView.swift
//  WNS
//
//  Created by J Oh on 9/1/24.
//

import UIKit
import TagListView

class CustomTagListView: TagListView {
 
    override func addTag(_ title: String) -> TagView {
        let tagView = super.addTag(title)
        configureTagView(tagView)
        return tagView
    }
 
    private func configureTagView(_ tagView: TagView) {
        
        tagView.enableRemoveButton = true
        tagView.paddingX = 12
        tagView.paddingY = 8
        tagView.removeIconLineColor = .label
    }
}
