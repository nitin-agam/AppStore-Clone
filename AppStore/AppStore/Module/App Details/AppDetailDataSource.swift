//
//  AppDetailDataSource.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 23/11/22.
//

import Foundation

class AppDetailDataSource {
    
    var searchResult: SearchResult?
    var reviews: Reviews?
    
    func fetchRequest(appId: String, _ completion: (() -> ())?) {
        
        Networking.sendRequest(.lookup(appId: appId)) { result in
            switch result {
            case .success(let data):
                do {
                    self.searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                } catch let jsonError {
                    Log.log("failed to parse app detail result with error: \(jsonError)", type: .error)
                }
                
                self.fetchReviews(appId: appId, completion)
                
            case .failure(let error):
                Log.log("failed to fetch app details result with error: \(error.title)", type: .error)
                completion?()
            }
        }
    }
    
    func fetchReviews(appId: String, _ completion: (() -> ())?) {
        Networking.sendRequest(.reviews(appId: appId)) { result in
            switch result {
            case .success(let data):
                do {
                    self.reviews = try JSONDecoder().decode(Reviews.self, from: data)
                } catch let jsonError {
                    Log.log("failed to parse app review result with error: \(jsonError)", type: .error)
                }
                
                completion?()
                
            case .failure(let error):
                Log.log("failed to fetch app review result with error: \(error.title)", type: .error)
                completion?()
            }
        }
    }
    
    func numberOfRows() -> Int {
        guard let result = searchResult else { return 0 }
        return result.results.count == 0 ? 0 : 3
    }
    
    func object() -> AppData? {
        guard let result = searchResult else { return nil }
        return result.results.first
    }
}


struct Reviews: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let author: Author
    let title: Label
    let content: Label
    
    let rating: Label
    
    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct Author: Decodable {
    let name: Label
}

struct Label: Decodable {
    let label: String
}
