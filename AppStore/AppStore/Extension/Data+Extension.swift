//
//  Data+Extension.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

extension Data {
    
    var dictionary: [String: Any]? {
        do {
            let responseData = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
            return responseData
        } catch {
            return nil
        }
    }

    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
