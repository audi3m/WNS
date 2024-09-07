//
//  TokenInterceptor.swift
//  WNS
//
//  Created by J Oh on 9/3/24.
//

import Foundation
import Alamofire

final class TokenInterceptor: RequestInterceptor {
    
    static let shared = TokenInterceptor()
    private init() { }
    
    private let retryLimit = 1
    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.headers.add(name: Header.authorization, value: AccountManager.shared.access)
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse
        print("retry")
        if response?.statusCode == 419, request.retryCount < retryLimit {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                isRefreshing = true
                
                AccountNetworkManager.shared.refreshAccessToken { [weak self] in
                    guard let self else { return }
                    self.isRefreshing = false
                    self.requestsToRetry.forEach { $0(.retry) }
                    self.requestsToRetry.removeAll()
                    print("토근 갱신 성공")
                } onFail: { [weak self] errorMessage in
                    guard let self else { return }
                    self.isRefreshing = false
                    self.requestsToRetry.forEach { $0(.doNotRetry) }
                    self.requestsToRetry.removeAll()
                    print("토큰 갱신 실패: \(errorMessage)")
                }
            }
        } else {
            completion(.doNotRetry)
        }
    } 
    
    private func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        AccountNetworkManager.shared.refreshAccessToken {
            completion(true)
        } onFail: { message in
            print(message)
            completion(false)
        }
    }
}
