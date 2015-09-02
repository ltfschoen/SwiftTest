//
//  ViewController.swift
//  FreeWifiSearch
//
//  Created by LS on 2/09/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    private var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager = CLLocationManager()

        // Delegate Object for updated events
        self.locationManager.delegate = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.checkLocationAuthorizationStatus()
    }

    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

/* CLLocationManagerDelegate Protocol defines methods to receive location and heading updates from CLLocationManager Object
*/
extension ViewController: CLLocationManagerDelegate {

    // Communicates to Delegate that authorization status for app changed
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.checkLocationAuthorizationStatus()
    }

}