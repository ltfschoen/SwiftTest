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

    /* Property Declarations that hook variables in Interface Builder (IB). IBOutlets are set implicitly unwrapped as Optional Type prefixed with ! (so IBOutlets may be used without checking for nil but runtime crash will occur if value is nil) since IB supplies Views at Runtime the Swift Compiler does not know and would give error that variables values not set in all initializers, so do not use an IBOutlet before the View of the ViewController has loaded. IBOutlets are declared as weak by default since the View of a ViewController holds Strong References to its outlets
    */
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var loginView: FBLoginView! // FBLoginView instead of UIView

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