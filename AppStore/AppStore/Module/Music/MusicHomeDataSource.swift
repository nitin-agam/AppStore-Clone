//
//  MusicHomeDataSource.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 13/12/22.
//

import Foundation

class MusicHomeDataSource {
    
    var searchResult: SearchResult?
    var isPaginating = false
    var hasMoreFeed = true
    
    private func fetchRequest(searchText: String, _ completion: ((_ result: SearchResult?) -> ())?) {
        
        Networking.sendRequest(.searchMusic(name: searchText, offset: searchResult?.resultCount ?? 0)) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion?(result)
                } catch let jsonError {
                    Log.log("failed to parse music result with error: \(jsonError)", type: .error)
                    completion?(nil)
                }
                
            case .failure(let error):
                Log.log("failed to fetch music result with error: \(error.title)", type: .error)
                completion?(nil)
            }
        }
    }
    
    func search(searchText: String, newSearch: Bool, _ completion: ((_ isSuccess: Bool) -> ())?) {
        self.fetchRequest(searchText: searchText) { result in
            
            guard let result = result else {
                completion?(false)
                return
            }
            
            if newSearch == false,
                let searchResultObject = self.searchResult,
               searchResultObject.results.isEmpty == false {
                if result.results.isEmpty {
                    self.hasMoreFeed = false
                } else {
                    self.hasMoreFeed = true
                    self.searchResult?.results  += result.results
                }
            } else {
                self.searchResult = result
            }

            completion?(true)
        }
    }
    
    func numberOfSection() -> Int {
        guard let result = searchResult else { return 0 }
        return result.results.count == 0 ? 0 : 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let result = searchResult else { return 0 }
        return result.results.count
    }
    
    func object(at indexPath: IndexPath) -> AppData? {
        guard let result = searchResult, indexPath.row < result.results.count else { return nil }
        return result.results[indexPath.row]
    }
}
