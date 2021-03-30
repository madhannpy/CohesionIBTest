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
    var circularRegion: CLCircularRegion
    
    init(center: CLLocationCoordinate2D, radius:CLLocationDistance, name identifier: String) {
        self.center = center
        self.radius = radius
        name = identifier
        monitoredStatus = false
        circularRegion = CLCircularRegion.init(center: center,
        radius: radius,
        identifier: identifier)
    }
    
    var description: String {
        return "\(name): lat - \(center.latitude), lon - \(center.longitude), radius - \(radius)"
    }
}


