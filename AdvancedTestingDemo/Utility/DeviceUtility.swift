//
//  DeviceUtility.swift
//  AdvancedTestingDemo
//
//  Created by RishiChaurasia on 18/04/22.
//
import UIKit

import Foundation
struct DeviceUtility {
    static func isRunningOnSimulator() -> Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }

}

