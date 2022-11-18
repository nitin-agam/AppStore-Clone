//
//  NetworkKeys.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

struct NetworkKeys {
    
    static func basePath(version: Int = 1) -> String {
        version > 0 ? "/\(version)" : ""
    }
    
    static let scheme = "https"
    static let baseHostName = "itunes.apple.com"
}
