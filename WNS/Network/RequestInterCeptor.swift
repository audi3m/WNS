//
//  RequestInterCeptor.swift
//  WNS
//
//  Created by J Oh on 9/3/24.
//

import Foundation
import Alamofire

final class TokenInterCeptor: RequestInterceptor {
    static let shared = TokenInterCeptor()
    private init() { }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        
    }
    
    func adapt(_ urlRequest: URLRequest, using state: RequestAdapterState, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        
    }
    
    
    
    
}
