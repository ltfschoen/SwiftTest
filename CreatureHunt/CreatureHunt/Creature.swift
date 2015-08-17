//
// Creature.swift
//  
//
// Created by LS on 13/08/2015.
//
// Progress: Page 56/XX (Ch3) / 257

/* Readme:
    - Class to hold Creatures
    - Struct to hold Map Locations
    - View Controller to add Creatures to Map Locations
*/

// Questions:
/* - Why doesn't Xcode v7.0 beta 4 give error "Class 'xyz' has no initializers (i.e. p50, since a Class with Constants (Non-Optional Types) must be initialized with valid values)?
   - Why no compiler errors in initializer when code references properties that have been removed from the Class itself in Xcode v7.0 beta 4?
   - Why isn't init('what: String',...) used for HQTreasure Class p55 like the other classes?
   - How to build and run the app to check that it works correctly (p56)?
*/

// Imports entire Foundation framework for access to Classes, Structs, Functions,
// and Objects (i.e. NSObject)
// Swift has its own Implementations of Classes in Foundation framework including
// Strings, Arrays, Dictionaries
import Foundation

// Import MapKit (MKMapView) to add annotations to the map conforming to the MKAnnotation Protocol
import MapKit

// Declare Protocol for conformance by all Sub Classes
@objc protocol Alertable {
    // alert() returns Alert Controller from View Controller when callout box pressed of tapped pin
    func alert() -> UIAlertController
}

// Declaration of a Class (Function)
// Declare Properties, Define Types, Set Values of Class (var/let)
// Declared so Class inherits from NSObject (since Class Extension uses MKAnnotation Protocol
// MKAnnotation Protocol that interfaces with Objective-C code
// (MKAnnotation Protocol inherits from NSObjectProtocol)
class Creature: NSObject {
    let what: String
    let location: GeoLocation
//    let latitude: Double
//    let longitude: Double

    // Initializer of all variables in the Class for it to exist
    init(what: String, location: GeoLocation) {
//    init(what: String, latitude: Double, longitude: Double) {
        self.what = what
        self.location = location
//        self.GeoLocation = GeoLocation
//        self.latitude = latitude
//        self.longitude = longitude
    }
    
    // Convenience Initializers (of Objects to avoid creating GeoLocation instances)
    // Defers Initialization to Designated Initializer (non-convenience initializer)
    convenience init(what: String,
                     latitude: Double,
                     longitude: Double)
    {
       let location = GeoLocation(latitude: latitude,
                                 longitude: longitude)
        self.init(what: what, location: location)
    }

//    func pinColor() -> MKPinAnnotationColor {
//        return MKPinAnnotationColor.Red
//    }

    // Default implementation of Polymorphism on map pin color. Sub Class override for different colour
    // pinTinColor instead of pinColor (deprecated)
    // Note: Attempted to return UIColor type of redPinColor() differs from deprecated solution
    func pinTintColor() -> UIColor {
        return MKPinAnnotationView.redPinColor()
    }

}

/*  Class Extension to split up the Class into Logical Units for additional functionality. Uses 'import MapKit' to allow additional properties and methods. Logical Unit declared here is MKAnnotation Protocol conformance, requiring definition of two Computed Properties (not Functions) with associated code that are computed each time without using an instance variable.
    Note: NSObjectProtocol conformance (part of Foundation framework) is also required since MKAnnotation inherits from it
*/
extension Creature: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return self.location.coordinate
    }

    var title: String? {
        return self.what
    }
}

// Class Inheritance
final class HistoryCreature: Creature { // Declare Class to Inherit from Super Class
    let year: Int

    init(what: String, year: Int, latitude: Double, longitude: Double)
    {
        self.year = year // Extra Fields not initialised by Super Class so must be given a Class Designated Initializer
        let location = GeoLocation(latitude: latitude, longitude: longitude)
        super.init(what: what, location: location) // Class Designated Initializer at end of method initializes fields declared in this class and then must call its Super Class Designated Initializer (not a Convenience Initializer). Super Class is not aware of other fields declared in Sub Classes so cannot overwrite them
    }

    // Sub Class that overrides Default Implementation using Polymorphism
    override func pinTintColor() -> UIColor {
        return MKPinAnnotationView.purplePinColor()
    }
}

final class ProtectedCreature: Creature {
    let protected: Bool

    init(what: String, protected: Bool, latitude: Double, longitude: Double)
    {
        self.protected = protected
        let location = GeoLocation(latitude: latitude, longitude: longitude)
        super.init(what: what, location: location)
    }

    // No Sub Class override method for pinTintColor so it will revert to default implementation of red
}

final class TaggedCreature: Creature {
    let tag: String

    init(what: String, tag: String, latitude: Double, longitude: Double) {
        self.tag = tag
        let location = GeoLocation(latitude: latitude, longitude: longitude)
        super.init(what: what + ": " + tag + " (tag id)", location: location)
    }

    override func pinTintColor() -> UIColor {
        return MKPinAnnotationView.greenPinColor()
    }
}

extension HistoryCreature: Alertable {
    func alert() -> UIAlertController {
        let alert = UIAlertController(
            title: "History",
            message: "From \(self.year):\n\(self.what)",
            preferredStyle: UIAlertControllerStyle.Alert) // Modal Alert
        return alert
    }
}

extension ProtectedCreature: Alertable {
    func alert() -> UIAlertController {
        let alert = UIAlertController(
            title: "Protected",
            message: "From \(self.what):\n\(self.protected)",
            preferredStyle: UIAlertControllerStyle.Alert) // Modal Alert
        return alert
    }
}

extension TaggedCreature: Alertable {
    func alert() -> UIAlertController {
        let alert = UIAlertController(
            title: "Tagged",
            message: "Tagged \(self.what):\n\(self.tag)",
            preferredStyle: UIAlertControllerStyle.Alert) // Modal Alert
        return alert
    }
}