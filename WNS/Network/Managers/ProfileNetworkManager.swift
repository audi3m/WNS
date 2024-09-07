//
//  ProfileNetworkManager.swift
//  WNS
//
//  Created by J Oh on 9/7/24.
//

import Foundation
import Alamofire

// Profile
final class ProfileNetworkManager {
    
    static let shared = ProfileNetworkManager()
    private init() { }
    
    func getMyProfile(handler: @escaping ((GetMyProfileResponse) -> Void)) {
        do {
            let request = try Router.getMyProfile.asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetMyProfileResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                            default:
                                print("Failed: \(failure)")
                            }
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func editMyProfile(body: ProfileBody, handler: @escaping ((EditMyProfileResponse) -> Void)) {
        do {
            let request = try Router.editMyProfile(body: body).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: EditMyProfileResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 400:
                                print("잘못된 요청입니다")
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                            default:
                                print("Failed: \(failure)")
                            }
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
    func getOthersProfile(userID: String, handler: @escaping ((GetOthersProfileResponse) -> Void)) {
        do {
            let request = try Router.getOthersProfile(userID: userID).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: GetOthersProfileResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        dump(response)
                        handler(response)
                    case .failure(let failure):
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 401:
                                print("인증할 수 없는 액세스 토큰입니다")
                            case 403:
                                print("Forbidden")
                            case 419:
                                print("액세스 토큰이 만료되었습니다")
                            default:
                                print("Failed: \(failure)")
                            }
                        }
                    }
                }
            
        } catch {
            print(error)
        }
    }
    
}
