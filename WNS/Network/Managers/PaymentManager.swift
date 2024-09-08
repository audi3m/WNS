//
//  PaymentManager.swift
//  WNS
//
//  Created by J Oh on 9/8/24.
//

import Foundation
import Alamofire

enum PaymentsError: Error {
    case invalidRequest // 400
    case tokenUnavailable // 401
    case forbidden // 403
    case validatedPayment // 409
    case postNotFound // 410
    case accessTokenExpired // 419
    case unknown
    case statusCodeError
}

// Payments
final class PaymentManager {
    
    static let shared = PaymentManager()
    private init() { }
    
    func checkPayments(body: PaymentsBody, handler: @escaping (Result<PaymentsResponse, PaymentsError>) -> Void) {
        do {
            let request = try Router.payments(body: body).asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: PaymentsResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("유효하지 않은 결제건입니다/필수값을 채워주세요")
                                handler(.failure(.invalidRequest))
                            case 401:
                                print("인증할 수 없는 액세스/리프레시 토큰입니다")
                                handler(.failure(.tokenUnavailable))
                            case 403:
                                print("Forbidden")
                                handler(.failure(.forbidden))
                            case 409:
                                print("검증처리가 완료된 결제건입니다")
                                handler(.failure(.validatedPayment))
                            case 410:
                                print("게시글을 찾을 수 없습니다")
                                handler(.failure(.postNotFound))
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                                handler(.failure(.accessTokenExpired))
                            default:
                                print("Failed: \(failure)")
                                handler(.failure(.unknown))
                            }
                        } else {
                            print("Status Code Error")
                            handler(.failure(.statusCodeError))
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func getPaymentsList(body: PaymentsBody, handler: @escaping (Result<PaymentsListResponse, PaymentsError>) -> Void) {
        do {
            let request = try Router.paymentsList.asURLRequest()
            AF.request(request, interceptor: TokenInterceptor.shared)
                .validate(statusCode: 200...299)
                .responseDecodable(of: PaymentsListResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        handler(.success(response))
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스/리프레시 토큰입니다")
                                handler(.failure(.tokenUnavailable))
                            case 403:
                                print("Forbidden")
                                handler(.failure(.forbidden))
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                                handler(.failure(.accessTokenExpired))
                            default:
                                print("Failed: \(failure)")
                                handler(.failure(.unknown))
                            }
                        } else {
                            print("Status Code Error")
                            handler(.failure(.statusCodeError))
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
}
