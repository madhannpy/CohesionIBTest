//
//  LocationManager.swift
//  CohesionTest
//
//  Created by Madhan C on 29/03/21.
//  Copyright © 2021 Madhan C. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var geofences = [Geofence]()
    var logger: Logger?
    
    func initialize() {
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        prepareGeofences()
        logger?.log("Location Manager Initialized")
    }
    
    func prepareGeofences() {
        let coordinateData = Utilities.coordinatesDataArray()
        for index in 0..<coordinateData.count {
            let geofence = Geofence(center: coordinateData[index].coordinate, radius: 300, name: coordinateData[index].name)
            geofences.append(geofence)
        }
    }
    
    func monitor(status:Bool) {
        for geofence in geofences {
            if geofence.monitoredStatus == status {
                return
            }
            else {
                geofence.monitoredStatus = status
                geofence.circularRegion.notifyOnEntry = status
                geofence.circularRegion.notifyOnExit = status
                if status == true {
                    locationManager.startMonitoring(for: geofence.circularRegion)
                }
                else {
                    locationManager.stopMonitoring(for: geofence.circularRegion)
                }
                logger?.log("\(geofence.description)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            logger?.log("Authorization status changed - \(String(describing: status))")
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        logger?.log("\nEntered Geofence:\(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        logger?.log("\nExited Geofence:\(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger?.log(error.localizedDescription)
    }
}

