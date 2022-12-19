//
//  TodayFeedsDataSource.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 30/11/22.
//

import Foundation

class TodayFeedsDataSource {
    
    private(set) var items: [TodayItem] = []
    
    
    func fetchData(_ completion: (() -> ())?) {
        
        var freeAppGroup: AppGroup?
        var paidAppGroup: AppGroup?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Networking.sendRequest(.appsFree) { result in
            Log.log("fetched top free apps...")
            switch result {
            case .success(let data):
                do {
                    freeAppGroup = try JSONDecoder().decode(AppGroup.self, from: data)
                } catch let jsonError {
                    Log.log("failed to parse apps free result with error: \(jsonError)", type: .error)
                }

            case .failure(let error):
                Log.log("failed to fetch apps free result with error: \(error.title)", type: .error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Networking.sendRequest(.appsPaid) { result in
            Log.log("fetched top paid apps...")
            switch result {
            case .success(let data):
                do {
                    paidAppGroup = try JSONDecoder().decode(AppGroup.self, from: data)
                } catch let jsonError {
                    Log.log("failed to parse apps paid result with error: \(jsonError)", type: .error)
                }

            case .failure(let error):
                Log.log("failed to fetch apps paid result with error: \(error.title)", type: .error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            
            let firstItem = TodayItem(category: "LIFE HACK", title: "Stay healthy all the time", imageName: "health", description: "All the protiens and vitamins you need to live healthy in right way.", backgroundColor: .white, result: nil, itemType: .single)
            
            let topFreeItem = TodayItem(category: "DAILY LIST", title: freeAppGroup?.feed.title ?? "", imageName: nil, description: nil, backgroundColor: .white, result: freeAppGroup?.feed.results, itemType: .multiple)
            
            let secondItem = TodayItem(category: "HOLIDAYS", title: "Travel on a Budget", imageName: "holiday", description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), result: nil, itemType: .single)
            
            let topPaidItem = TodayItem(category: "DAILY LIST", title: paidAppGroup?.feed.title ?? "", imageName: nil, description: nil, backgroundColor: .white, result: paidAppGroup?.feed.results, itemType: .multiple)
            
            self.items.append(contentsOf: [firstItem, topFreeItem, secondItem, topPaidItem])
            
            completion?()
        }
    }
}
