//
//  NSObject+Ex.swift
//  WNS
//
//  Created by J Oh on 8/18/24.
//

import Foundation

extension NSObject {
    static var id: String {
        String(describing: self)
    }
}
