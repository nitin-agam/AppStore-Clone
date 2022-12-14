//
//  NetworkEndpoint.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

enum NetworkEndpoint {
    case searchApp(name: String)
    case appsFree
    case appsPaid
    case socialApps
    case lookup(appId: String)
    case reviews(appId: String)
    case searchMusic(name: String, offset: Int)
}

extension NetworkEndpoint {
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
}

extension NetworkEndpoint {
    
    var urlRequest: URLRequest? {
        switch self {
        case .searchApp(let name):
            let queryItems: [QueryItem] = [QueryItem(key: "term", value: name),
                                           QueryItem(key: "entity", value: "software")]
            return .make(endpoint: "search", headers: nil, queries: queryItems, method: .GET, version: 0, params: nil)
            
        case .appsFree:
            return .makeStatic("https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json")
            
        case .appsPaid:
            return .makeStatic("https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json")
            
        case .socialApps:
            return .makeStatic("https://api.letsbuildthatapp.com/appstore/social")
            
        case .lookup(let appId):
            return .makeStatic("https://itunes.apple.com/lookup?id=\(appId)")
            
        case .reviews(let appId):
            return .makeStatic("https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us")
            
        case .searchMusic(let name, let offset):
            let queryItems: [QueryItem] = [QueryItem(key: "term", value: name),
                                           QueryItem(key: "offset", value: String(offset)),
                                           QueryItem(key: "limit", value: "20")]
            return .make(endpoint: "search", headers: nil, queries: queryItems, method: .GET, version: 0, params: nil)
        }
    }
}

extension URLRequest {
    
    static func make(endpoint: String, headers: [HeaderField]?, queries: [QueryItem]?, method: NetworkEndpoint.HTTPMethod = .GET, version: Int = 0, params: [String: Any]? = nil) -> URLRequest? {
        
        var urlComponents = RequestFactory.baseURLComponents(baseVersion: version)
        urlComponents.path.append("/" + endpoint)
        
        if let queryArray = queries, queryArray.isEmpty == false {
            queryArray.forEach { (item) in
                urlComponents.queryItems?.append(URLQueryItem(name: item.key, value: item.value))
            }
        }
        
        if let url = urlComponents.url {
            var request = RequestFactory.baseURLRequest(url: url)
            request.httpMethod = method.rawValue
            if let parameters = params {
                request.httpBody = NetworkManager.convertToData(parameters)
            }
            
            if let headerArray = headers, headerArray.isEmpty == false {
                headerArray.forEach { (headerField) in
                    request.setValue(headerField.value, forHTTPHeaderField: headerField.key)
                }
            }
            
            return request
        }
        return nil
    }
    
    static func makeStatic(_ urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
}

struct QueryItem {
    let key: String
    let value: String
}

struct HeaderField {
    let key: String
    let value: String
}

