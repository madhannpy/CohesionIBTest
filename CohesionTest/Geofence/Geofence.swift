//
//  GeofenceAPI.swift
//  CohesionTest
//
//  Created by Madhan C on 27/03/21.
//  Copyright © 2021 Madhan C. All rights reserved.
//

import Foundation
import CoreLocation

class Geofence {
    
    var center : CLLocationCoordinate2D
    var radius : CLLocationDistance
    var name: String
    var monitoredStatus: Bool
    
    func circularRegion() -> (CLCircularRegion) {
        let region = (CLCircularRegion.init(center: center,
        radius: radius,
        identifier: name))
        return region
    }
    
    init(center: CLLocationCoordinate2D, radius:CLLocationDistance, name identifier: String) {
        self.center = center
        self.radius = radius
        name = identifier
        monitoredStatus = false
    }
    
    var description: String {
        return "\(name): lat - \(center.latitude), lon - \(center.longitude), radius - \(radius)"
    }
}


