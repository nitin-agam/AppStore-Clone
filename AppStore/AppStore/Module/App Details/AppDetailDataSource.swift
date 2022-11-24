//
//  AppDetailDataSource.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 23/11/22.
//

import Foundation

class AppDetailDataSource {
    
    var searchResult: SearchResult?
    
    func fetchRequest(appId: String, _ completion: (() -> ())?) {
        
        Networking.sendRequest(.lookup(appId: appId)) { result in
            switch result {
            case .success(let data):
                do {
                    self.searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                } catch let jsonError {
                    Log.log("failed to parse app detail result with error: \(jsonError)", type: .error)
                }
                
                completion?()
                
            case .failure(let error):
                Log.log("failed to fetch app details result with error: \(error.title)", type: .error)
                completion?()
            }
        }
    }
    
    func numberOfRows() -> Int {
        guard let result = searchResult else { return 0 }
        return result.results.count == 0 ? 0 : 2
    }
    
    func object() -> AppData? {
        guard let result = searchResult else { return nil }
        return result.results.first
    }
}
