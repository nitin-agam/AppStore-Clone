//
//  NetworkManager.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

var Networking: NetworkManager {
    return NetworkManager.shared
}

class NetworkManager {
    
    // MARK: - Properties
    static let shared: NetworkManager = NetworkManager()
    typealias Handler = ((Result<Data, NetworkError>) -> ())?
    
    
    // MARK: - Public Methods
    func sendRequest(_ endpoint: NetworkEndpoint, completion: Handler) {
        guard let request = endpoint.urlRequest else { return }
        executeRequest(request: request, completion: completion)
    }
    
    
    // MARK: - Private Method
    private func executeRequest(request: URLRequest, completion: Handler) {
        
        guard NetworkReachability.shared.isNetworkReachable() else {
            Log.log(String.ErrorMessage.noInternet, type: .error)
            completion?(.failure(NetworkError(title: String.ErrorMessage.noInternet)))
            return
        }
        
        Log.logStartRequest(request)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let self = self {
                Log.logEndRequest(response, data: data, error: error)
                self.result(from: data, response: response, request: request, completion)
            } else {
                Log.log("Something is wrong with Network Manager class.", type: .error)
                completion?(.failure(NetworkError(title: String.ErrorMessage.noInternet)))
            }
        }
        dataTask.resume()
    }
}

// MARK: - Utility Methods
extension NetworkManager {
    
    class func convertToData(_ value: Any) -> Data {
        if let str =  value as? String {
            return str.data(using: String.Encoding.utf8)!
        } else if let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted) {
            return jsonData
        } else {
            return Data()
        }
    }
    
    func result(from data: Data?, response: URLResponse?, request: URLRequest, _ completion: Handler) {
        guard let data = data else {
            completion?(.failure(NetworkError(title: String.ErrorMessage.invalidResponse)))
            return
        }
        
        do {
            let _ = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            completion?(.success(data))
        } catch let error {
            Log.log("Error during parsing data is: \(error)", type: .error)
            completion?(.failure(NetworkError(title: String.ErrorMessage.invalidParsing)))
        }
    }
}
