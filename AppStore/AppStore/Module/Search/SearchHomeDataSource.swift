//
//  SearchHomeDataSource.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import Foundation

class SearchHomeDataSource {
    
    var searchResult: SearchResult?
    
    func fetchRequest(searchText: String, _ completion: ((_ isSuccess: Bool) -> ())?) {
        
        Networking.sendRequest(.searchApp(name: searchText)) { result in
            switch result {
            case .success(let data):
                do {
                    self.searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion?(true)
                } catch let jsonError {
                    Log.log("failed to parse search result with error: \(jsonError)", type: .error)
                    completion?(false)
                }
                
            case .failure(let error):
                Log.log("failed to fetch search result with error: \(error.title)", type: .error)
                completion?(false)
            }
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

struct SearchResult: Decodable {
    let resultCount: Int
    var results: [AppData]
}

struct AppData: Decodable {
    var trackId: Int?
    var trackName: String?
    let primaryGenreName: String
    var averageUserRating: Float?
    var screenshotUrls: [String]?
    let artworkUrl100: String
    var formattedPrice: String?
    var description: String?
    var releaseNotes: String?
    var artistName: String?
    var version: String?
    
}
