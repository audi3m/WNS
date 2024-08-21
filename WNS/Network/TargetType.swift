//
//  TargetType.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String] { get }
    var parameters: String? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        
//        let url = try baseURL.asURL()
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        
        if let queryItems {
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            throw AFError.invalidURL(url: baseURL)
        }
        
        var request = try URLRequest(url: url, method: method)
        request.allHTTPHeaderFields = header
        
        request.httpBody = body
        return request
    }
}
