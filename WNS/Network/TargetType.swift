//
//  TargetType.swift
//  WNS
//
//  Created by J Oh on 8/14/24.
//

import Foundation
import Alamofire

enum RequestError: Error {
    case invalidURL
}

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: String? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension TargetType {
    
    func asURLRequest() throws -> URLRequest {
        
        var url = try baseURL.asURL()
        if let queryItems {
            url.append(queryItems: queryItems)
        }
        var request = try URLRequest(url: url.appendingPathComponent(path), method: method)
//        request.allHTTPHeaderFields = header
        request.headers = headers
        request.httpBody = body
        print(request)
        return request
        
    }
}
