//
//  GeoFenceViewController.swift
//  CohesionTest
//
//  Created by Madhan C on 26/03/21.
//  Copyright © 2021 Madhan C. All rights reserved.
//

import UIKit

class GeoFenceViewController: UIViewController, LoggerDelegate {
    
    var locationManager = LocationManager()
    var logger = Logger()

    override func viewDidLoad() {
        super.viewDidLoad()
        logger.delegate = self
        locationManager.logger = logger
        locationManager.initialize()
    }
    
    @IBOutlet weak var textView: UITextView!
    
    func updateLog(_ text: String) {
        textView.text = textView.text + "\n" + text
        textView.scrollToBottom()
        
    }
    
    @IBAction func startMonitoring(_ sender: Any) {
        logger.log("\nStarted monitoring Geofences:")
        locationManager.monitor(status: true)
    }
    
    @IBAction func stopMonitoring(_ sender: Any) {
        logger.log("\nStopped monitoring Geofences:")
        locationManager.monitor(status: false)
    }
}

extension UITextView {
    func scrollToBottom() {
        if self.text.count > 0 {
            let location = self.text.count - 1
            let bottom = NSMakeRange(location, 1)
            self.scrollRangeToVisible(bottom)
        }
    }
}
