//
//  ConnectionManager.swift
//  AdvancedTestingDemo
//
//  Created by RishiChaurasia on 18/04/22.
//

import Foundation
struct ConnectionManager {
    
    /// This function is responsible to check network connectivity of device and returns Bool.
    ///
    /// ```
    /// hasConnectivity
    /// ```
    ///
    /// - Returns: Bool value which states True for connectivity and False for No-Connectivity.
    
    static func hasConnectivity() -> Bool {
        do {
            let reachability: Reachability = try Reachability()
            let networkStatus = reachability.connection
            switch networkStatus {
            case .unavailable:
                return false
            case .wifi, .cellular:
                return true
            }
        } catch {
            return false
        }
    }
}
