//
//  BaseViewController.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import Foundation
import UIKit

class BaseViewController:UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observers()
    }
}


extension BaseViewController {
    
    func observers() {
        NotificationCenter.default
                    .addObserver(self,
                                 selector: #selector(statusManager),
                                 name: .flagsChanged,
                                 object: nil)
    }
    
}

extension BaseViewController {
    
    @objc
    private func statusManager(_ notification: Notification) {
        updateUserInterface()
    }

}

extension BaseViewController {
    
    func updateUserInterface() {
        switch Network.reachability.status {
        case .unreachable:
            networkReachable(status: false)
        case .wwan,.wifi:
            networkReachable(status: true)
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    
    /// called when device connected/disconnected to internet or its reachable
    func networkReachable(status:Bool) {
        
    }
    
    
}
