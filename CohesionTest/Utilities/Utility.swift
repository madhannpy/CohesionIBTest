//
//  Utility.swift
//  CohesionTest
//
//  Created by Madhan C on 29/03/21.
//  Copyright © 2021 Madhan C. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseAnalytics

class Utility {
    static func coordinatesArray() -> [CLLocationCoordinate2D] {
        let parser = GPXParser()
        let gpx: String = Bundle.main.path(forResource: "geofence", ofType: "gpx")!
        let coordinates = parser.parseCoordinates(fromGpxFile: gpx)
        return coordinates!
    }
    
}

protocol LoggerDelegate: NSObject {
    func updateLog(_ text: String)
}

class Logger {
    var delegate: LoggerDelegate?
    func log(_ text: String) {
        print(text)
        FirebaseAnalytics.Analytics.logEvent(text, parameters: nil)
        delegate?.updateLog(text)
        //NotificationCenter.default.post(name: NSNotification.Name("LogEvent"), object: nil, userInfo: [0 : text])
    }
}

class GPXParser: NSObject, XMLParserDelegate {
    
    var coordinates = [CLLocationCoordinate2D]()

    func parseCoordinates(fromGpxFile filePath: String) -> [CLLocationCoordinate2D]? {
        guard let data = FileManager.default.contents(atPath: filePath) else { return nil }
    
        let parser = XMLParser(data: data)
        parser.delegate = self

        let success = parser.parse()
    
        guard success else { return nil }
        return coordinates
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        guard elementName == "trkpt" || elementName == "wpt" else { return }
        guard let latString = attributeDict["lat"], let lonString = attributeDict["lon"] else { return }
        guard let lat = Double(latString), let lon = Double(lonString) else { return }
        guard let latDegrees = CLLocationDegrees(exactly: lat), let lonDegrees = CLLocationDegrees(exactly: lon) else { return }

        coordinates.append(CLLocationCoordinate2D(latitude: latDegrees, longitude: lonDegrees))
    }

}
