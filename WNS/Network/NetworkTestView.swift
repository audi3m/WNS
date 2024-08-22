//
//  NetworkTestView.swift
//  WNS
//
//  Created by J Oh on 8/16/24.
//

import UIKit

final class NetworkTestView: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let body = JoinBody(email: "ab@a.com", password: "aaaabbbb", nick: "My name is ab", phoneNum: "01011112222", birthDay: "20000202")
        NetworkManager.shared.join(body: body) { response in
            
        }
        
    }
}
