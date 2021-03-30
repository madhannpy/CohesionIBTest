//
//  GeoFenceViewController.swift
//  CohesionTest
//
//  Created by Madhan C on 26/03/21.
//  Copyright © 2021 Madhan C. All rights reserved.
//

import UIKit

class GeoFenceViewController: UIViewController {
    
    var locationManager = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.initialize()
    }
    
    @IBOutlet weak var textView: UITextView!
    {
        didSet {
            //to improve from Notification to delegation pattern..
            NotificationCenter.default.addObserver(self, selector: #selector(self.updateLog(notification:)), name: NSNotification.Name("LogEvent"), object: nil)
        }
    }
    
    @objc func updateLog(notification: Notification) {
        let log = notification.userInfo![0] as? String
        textView.text = textView.text + "\n" + log!
    }
    
    @IBAction func startMonitoring(_ sender: Any) {
        locationManager.monitor(status: true)
    }
    
    @IBAction func stopMonitoring(_ sender: Any) {
        locationManager.monitor(status: false)
    }
}
