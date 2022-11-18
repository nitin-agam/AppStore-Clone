//
//  NetworkError.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import Foundation

final class NetworkError: Error {
    
    var title: String
    var description: String?
    var errorCode: String?
    
    init(title: String, desc: String? = nil, _ code: String? = nil) {
        self.title = title
        self.description = desc
        self.errorCode = code
    }
}
