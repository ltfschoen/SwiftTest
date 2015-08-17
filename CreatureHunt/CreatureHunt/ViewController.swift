//
// ViewController.swift
// CreatureHunt
//
// Created by LS on 15/08/2015.
// Copyright © 2015 LS. All rights reserved.
//
// Progress: Page 68/XX (Ch3) / 257
//
// Questions:
//
/* - Why does using ? and ! in the following code snippet as directed result in error? 'func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {'
   - Why on page 61 doesn't it mention to define pinTintColor() in Treasure.swift in order to overcome error message saying it is not used (we aren't told to use pinColor until page 64)? Note that pinColor() used in the code solutions is deprecated now but when I apply updates I get an error 'fatal error: unexpectedly found nil while unwrapping an Optional value', what is causing this? Lack of internet connection to load the maps?
   - Why does using ! as directed on page 67 cause warning (i.e. 'func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {') ?
   - Why get error 'String is not convertible to StringLiteralConvertible' with code snippet 'alert.addAction(UIAlertAction(title: "Find Closest",' from page 69 ?
   - Why error that says 'find cannot be used and to use indexOf instead' when using code from page 73 'if let index = find(self.foundLocations, creature.location) {' ? The code compiles when change code to 'if let index = self.foundLocations.indexOf(creature.location) {'
*/

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet var mapView : MKMapView! // Interface Builder outlet for MKMapView

    var creatures: [Creature] = [] // Declare and initialise Array property

    var foundLocations: [GeoLocation] = [] // Declare and initialise Array property to hold array of GeoLocation structs to track the order that creatures are found by user
    var polyline: MKPolyline! // Declare and initialise property to hold an MKPolyline (overlay line on map to show set of points found by user) with the type being an implicitly unwrapped Optional (allowing a nil value before user has found any creatures)

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


        /* Map zoom to generated region containing all creatures and prevent having to manually pan and zoom. Algorithm using the Reduce Function of an array with initial seed value constant MKMapRectNull (represents an invalid rectangle) where at each step the current array element is added to a combined value (return value of function) and the next array element and the current combined value is passed along.
        */
        let rectToDisplay = self.creatures.reduce(MKMapRectNull) {
            (mapRect: MKMapRect, creature: Creature) -> MKMapRect in
            // Each step in Reduce Function requires calculation of rectangular map enclosing a single creature
            let creaturePointRect = MKMapRect(origin: creature.location.mapPoint, size: MKMapSize(width: 0, height: 0))
            // Return rectangle based on the Union of the current overall rectangle and single rectangle of current step
            return MKMapRectUnion(mapRect, creaturePointRect)
        }
        // Set map view visible with padding to prevent pins hidden under nav bar or screen edges
        self.mapView.setVisibleMapRect(rectToDisplay, edgePadding: UIEdgeInsetsMake(50, 5, 5, 5), animated: false)

    }

    func markCreatureAsFound(creature: Creature) {
        // Check to see if location already exists in found locations array
        // find() takes collection and element to find as arguments. Returns index where found or nil
        if let index = self.foundLocations.indexOf(creature.location) {
            let alert = UIAlertController(
                title: "Oops!",
                message: "Already found this Creature (at step \(index + 1)! Try again!",
                preferredStyle: .Alert)
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .Default,
                    handler: nil
                )
            )
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            // Add location to found locations array if it does not already exist in it
            self.foundLocations.append(creature.location)

            // Remove any existing polyline from map to prevent too many overlaying
            if self.polyline != nil {
                self.mapView.removeOverlay(self.polyline)
            }

            /* Create new MKPolyline and add it to map view. The .map function passes each element in array into supplied closure (as $0 variable) for conversion and creates new array with results. Short syntax for Closures (signature not included since Swift can infer it from the .map function signature.
            */
            var coordinates = self.foundLocations.map { $0.coordinate }
            self.polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
            self.mapView.addOverlay(self.polyline)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// Class Extension
// Purpose: Make ViewController conform to MKMapViewDelegate protocol so may be Delegate for map view
// Delegate Method is called when user taps the pin or pin callout button (i)
extension ViewController: MKMapViewDelegate {
    /* Implements mapView:viewForAnnotation to return view associated with specified annotation object. Pass in annotation of type MKAnnotation! (an Optional, so value may be nil, it is implicitly unwrapped so may be used without checking for nil but app will crash if it is nil). Note: Objective-C APIs are wrapped in this manner since it does not support Optionals like Swift
    */
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
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
            // Set pin colour for creature to returned value (differs depending on the creature type)
            // pinTintColor used instead of pinColor (deprecated)
            view.pinTintColor = creature.pinTintColor()

            return view
        }
        return nil
    }

    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        // Inline Downcast annotation of view to a Creature
        if let creature = view.annotation as? Creature {
            // Inline Downcast Creature to check it conforms to Alertable
            if let alertable = creature as? Alertable {
                // Display Creature alert dialog with OK button when tap callout (i) button
                let alert = alertable.alert()
                alert.addAction(
                    UIAlertAction(
                        title: "OK",
                        style: UIAlertActionStyle.Default,
                        handler: nil)
                )
                // Display Creature alert dialog with Found that they can tap when creature is found
                alert.addAction(
                    UIAlertAction(
                        title: "Found",
                        style: UIAlertActionStyle.Default) { action in
                            self.markCreatureAsFound(creature)
                        }
                )
                alert.addAction(
                    UIAlertAction(
                        title: "Find Closest",
                        style: UIAlertViewStyle.Default) { action in
                            var sortedCreatures = self.creatures // Local variable hold copy of array
                            // Sort Method takes single parameter (Closure taking two objects, returns Boolean if an object is before another)
                            sortedCreatures.sortInPlace({ // Closure
                                /*  Calc distance b/w current creature and each creature being sorted. Shorthand syntax $0 and $1 represents 1st and 2nd params passed into closure
                                */
                                let distanceA = creature.location.distanceBetween($0.location)
                                let distanceB = creature.location.distanceBetween($1.location)
                                // Sort array of creatures in order from shortest to longest distance from current creature
                                return distanceA < distanceB
                            })
                            /* Deselect current creature. Select new creature (2nd elem in sorted array since 1st elem is current creature)
                            */
                            mapView.deselectAnnotation(creature, animated: true)
                            mapView.selectAnnotation(sortedCreatures[1], animated: true)
                        } // end UIAlertAction style block
                ) // end alert.addAction
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }

    // Render an overlay (overlay MKPolyline has renderer MKPolylineRenderer) of a map view
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        // Inline Downcast overlay type to MKPolyline for Optional checking
        if let polylineOverlay = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polylineOverlay)
            renderer.strokeColor = UIColor.blueColor()
            return renderer
        }
        return nil
    }
}