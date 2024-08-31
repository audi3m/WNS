//
//  WineSelectViewModel.swift
//  WNS
//
//  Created by J Oh on 8/31/24.
//

import Foundation
import RxSwift
import RxCocoa

final class WineSelectViewModel {
    
    var results = [Wine]()
    let wineList: [Wine]
    
    struct Input {
        let query: ControlProperty<String>
    }
    
    struct Output {
        let searchResults: Observable<[Wine]>
    }
    
    init() {
        WineListManager.shared.wineListJSON = WineData.wineList
        self.wineList = WineListManager.shared.wineList
    }
    
    func transform(input: Input) -> Output {
        let searchResults = input.query
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [unowned self] query -> Observable<[Wine]> in
                if query.isEmpty {
                    return Observable.just(wineList)
                } else {
                    let filteredWines = self.wineList.filter { wine in
                        wine.name.lowercased().contains(query.lowercased()) ||
                        wine.type.lowercased().contains(query.lowercased()) ||
                        wine.variety.lowercased().contains(query.lowercased()) ||
                        wine.region.lowercased().contains(query.lowercased()) ||
                        wine.country.lowercased().contains(query.lowercased())
                    }
                    return Observable.just(filteredWines)
                }
            }
            .observe(on: MainScheduler.instance)
        
        return Output(searchResults: searchResults)
    }
    
}
