//
//  UIImageView+Ex.swift
//  WNS
//
//  Created by J Oh on 8/25/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageWithURL(with fileURL: String) {
        guard let url = URL(string: APIKey.baseURL + "v1/" + fileURL) else { return }
        let headers = [
            Header.authorization: AccountManager.shared.access,
            Header.sesacKey: APIKey.key
        ]
        let kfOptions: KingfisherOptionsInfo = [
            .requestModifier(RequestModifier(headers: headers))
        ]
         
        self.kf.setImage(with: url, options: kfOptions)
    }
}
 
struct RequestModifier: ImageDownloadRequestModifier {
    let headers: [String: String]
    
    func modified(for request: URLRequest) -> URLRequest? {
        var request = request
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
