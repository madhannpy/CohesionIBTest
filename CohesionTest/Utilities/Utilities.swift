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

class Utilities {
    static func coordinatesDataArray() -> [(coordinate:CLLocationCoordinate2D, name: String)] {
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
    }
}

class GPXParser: NSObject, XMLParserDelegate {
    
    var coordinates = [CLLocationCoordinate2D]()
    var names = [String]()
    var data = ""
    var gpxData = [(CLLocationCoordinate2D, String)]()

    func parseCoordinates(fromGpxFile filePath: String) -> [(CLLocationCoordinate2D, String)]? {
        guard let data = FileManager.default.contents(atPath: filePath) else { return nil }
    
        let parser = XMLParser(data: data)
        parser.delegate = self

        let success = parser.parse()
    
        guard success else { return nil }
        
        for index in 0..<coordinates.count {
            gpxData.append((coordinates[index], names[index]))
        }
        return gpxData
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        guard elementName == "trkpt" || elementName == "wpt" || elementName == "name" else { return }
        guard let latString = attributeDict["lat"], let lonString = attributeDict["lon"] else { return }
        guard let lat = Double(latString), let lon = Double(lonString) else { return }
        guard let latDegrees = CLLocationDegrees(exactly: lat), let lonDegrees = CLLocationDegrees(exactly: lon) else { return }
        coordinates.append(CLLocationCoordinate2D(latitude: latDegrees, longitude: lonDegrees))
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "name"){
            names.append(data)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.data = data
        
    }
    
}
