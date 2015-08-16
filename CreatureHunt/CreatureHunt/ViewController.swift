//
//  ViewController.swift
//  CreatureHunt
//
//  Created by LS on 15/08/2015.
//  Copyright © 2015 LS. All rights reserved.
//

// Questions:
//
/* - Why does using ? and ! in the following code snippet as directed result in error? 'func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {'
*/

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet var mapView : MKMapView! // Interface Builder outlet for MKMapView

    var creatures: [Creature] = [] // Declare and initialise Array property

    // Overriding Method to override behaviour of superclass Existing Method (ViewController)
    // View Controller calls after app has loaded the View. Customise View here.
    override func viewDidLoad() {
        super.viewDidLoad() // Call Existing Method defined by superclass
        // Do any additional setup after loading the view, typically from a nib.

        // Setup all elements in declared variable Array
        self.creatures = [
            HistoryCreature(what: "Moose", year: 2015, latitude: 37.5, longitude: -100.5),
            ProtectedCreature(what: "Manitee", protected: true, latitude: 40.5, longitude: -50.5),
            TaggedCreature(what: "Manitee", tag: "big mani", latitude: 10.5, longitude: -30.5)
        ]

        self.mapView.delegate = self // Declare View Controller as Delegate of Map View to allow display
        self.mapView.addAnnotations(self.creatures) // Add Array to Map as annotations
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// Class Extension
// Purpose: Make ViewController conform to MKMapViewDelegate protocol so may be Delegate for map view
extension ViewController: MKMapViewDelegate {
    /* Implements mapView:viewForAnnotation to return view associated with specified annotation object. Pass in annotation of type MKAnnotation! (an Optional, so value may be nil, it is implicitly unwrapped so may be used without checking for nil but app will crash if it is nil). Note: Objective-C APIs are wrapped in this manner since it does not support Optionals like Swift
    */
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        /* 'if statement' will only pass if Inline Downcast of the annotation to Creature occurs without error (since annotation could be nil or non-Creature instance)
        */
        if let creature = annotation as? Creature {
//        if let _ = annotation as? Creature {
            /* Dequeue a map view for reuse id "pin" (reuse existing map view previously onscreen rather than create new, similar to dequeue and reuse of UITableViewCell with UITableViews). Inline Downcast on Non-Optional form since we know all "pin" annotation views will be MKPinAnnotation instances
            */
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as! MKPinAnnotationView!
            // Create new view if no previous map view exists
            if view == nil {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
                view.canShowCallout = true
                view.animatesDrop = false
                view.calloutOffset = CGPoint(x: -5, y: 5)
//                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
                view.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure) as UIView
            } else {
                // Change annotation if an existing map view was dequeued
                view.annotation = annotation
            }
            // pinTintColor used instead of pinColor (deprecated)
            view.pinTintColor = creature.pinTintColor()

            return view
        }
        return nil
    }
}