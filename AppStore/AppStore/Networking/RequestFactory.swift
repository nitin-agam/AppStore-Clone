//
//  RequestFactory.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

class RequestFactory {
    
    static func baseURLComponents(baseVersion: Int = 1) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = NetworkKeys.scheme
        urlComponents.host = NetworkKeys.baseHostName
        urlComponents.path = NetworkKeys.basePath(version: baseVersion)
        urlComponents.queryItems = []
        return urlComponents
    }
    
    static func baseURLRequest(url: URL) -> URLRequest {
        baseRequest(url: url)
    }
    
    static func baseRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

