//
//  NetworkEndpoint.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

enum NetworkEndpoint {
    case searchApp(name: String)
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
}

struct QueryItem {
    let key: String
    let value: String
}

struct HeaderField {
    let key: String
    let value: String
}

