//
//  TestViewController.swift
//  WNS
//
//  Created by J Oh on 8/16/24.
//

import UIKit
import SnapKit

final class TestViewController: BaseViewController {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    let pickerView: UIPickerView = {
        let view = UIPickerView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}


extension TestViewController {
    private func configureView() {
        
    }
}
