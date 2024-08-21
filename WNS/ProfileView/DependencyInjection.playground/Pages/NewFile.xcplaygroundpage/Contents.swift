//: [Previous](@previous)

/*
 DI DIP
 Co
 
 */

import Foundation

protocol NetworkManagerProvider {
    func callRequest()
}

class MockNetworkManager: NetworkManagerProvider {
    
    func callRequest() {
        // response api
    }
}

class NetworkManager: NetworkManagerProvider {
    
    static let shared = NetworkManager()
    private init() { }
    
    // protocol 것이 됨
    func callRequest() {
        // Lotto api
    }

}

class NetworkManager2: NetworkManagerProvider {
    
    static let shared = NetworkManager()
    private init() { }
    
    // protocol 것이 됨
    func callRequest() {
        // TMDB api
    }
    
}

class LottoViewModel {
    
    private let networkProvider: NetworkManagerProvider
    
    init(networkProvider: NetworkManagerProvider) {
        self.networkProvider = networkProvider
    }
    
    func transform() {
        networkProvider.callRequest() // ??
    }
    
}


let viewModel = LottoViewModel(networkProvider: <#T##NetworkManagerProvider#>) // 누군지 모름.


// MVVM. testable. ??
// testable 한가요?


//: [Next](@next)
