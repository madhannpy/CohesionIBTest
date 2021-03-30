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
        print("text - \(text)")
        textView.text = textView.text + "\n" + text

    }
    
    @IBAction func startMonitoring(_ sender: Any) {
        locationManager.monitor(status: true)
    }
    
    @IBAction func stopMonitoring(_ sender: Any) {
        locationManager.monitor(status: false)
    }
}
