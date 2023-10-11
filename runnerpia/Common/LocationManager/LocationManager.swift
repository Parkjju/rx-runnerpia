//
//  LocationManager.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/11.
//

import Foundation
import CoreLocation

class LocationManager {
    static let shared = CLLocationManager()
    
    static func getAuthorizationStatus() -> CLAuthorizationStatus {
        return LocationManager.shared.authorizationStatus
    }
}
