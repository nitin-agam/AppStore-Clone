//
//  NetworkReachability.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit
import Reachability

class NetworkReachability: NSObject {
    
    private var reachability: Reachability?
    static let shared: NetworkReachability = NetworkReachability()
    
    override init() {
        
        do {
            reachability = try Reachability.init()
            try reachability?.startNotifier()
        } catch let error {
            Log.log(error.localizedDescription, type: .error)
        }
        
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: Notification.Name.reachabilityChanged, object: nil)
    }
    
    func isNetworkReachable() -> Bool {
        if (reachability?.connection) == .unavailable {
            return false
        } else {
            return true
        }
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        if let reachabilityObject = notification.object as? Reachability {
            if reachabilityObject.connection == .unavailable {
                NotificationCenter.default.post(name: .noInternetConnection,
                                                object: false)
            } else {
                NotificationCenter.default.post(name: .noInternetConnection,
                                                object: true)
            }
        }
    }
    
    deinit {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: nil)
    }
}
