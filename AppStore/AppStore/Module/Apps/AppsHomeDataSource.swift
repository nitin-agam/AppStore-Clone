//
//  AppsHomeDataSource.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 21/11/22.
//

import Foundation

class AppsHomeDataSource {
    
    var sectionGroups: [AppGroup] = []
    
    func fetchData(_ completion: (() -> ())?) {
        
        var appGroup1: AppGroup?
        var appGroup2: AppGroup?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Networking.sendRequest(.appsFree) { result in
            Log.log("fetched top free apps...")
            switch result {
            case .success(let data):
                do {
                    appGroup1 = try JSONDecoder().decode(AppGroup.self, from: data)
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
                    appGroup2 = try JSONDecoder().decode(AppGroup.self, from: data)
                } catch let jsonError {
                    Log.log("failed to parse apps paid result with error: \(jsonError)", type: .error)
                }

            case .failure(let error):
                Log.log("failed to fetch apps paid result with error: \(error.title)", type: .error)
            }
            
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .main) {
            self.sectionGroups = [appGroup1, appGroup2].compactMap{ $0 }
            Log.log("nos of section: \(self.sectionGroups.count)")
            completion?()
        }
    }
    
    func numberOfSection() -> Int {
        return sectionGroups.count == 0 ? 0 : 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sectionGroups.count
    }
    
    func object(at indexPath: IndexPath) -> AppGroup? {
        guard indexPath.row < sectionGroups.count else { return nil }
        return sectionGroups[indexPath.row]
    }
}


struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name: String
    let artistName: String
    let artworkUrl100: String
}
