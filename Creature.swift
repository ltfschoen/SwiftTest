//
// Creature.swift
//  
//
// Created by LS on 13/08/2015.
//
// Progress: Page 56/XX (Ch3) / 257

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

// Declaration of a Class (Function)
// Declare Properties, Define Types, Set Values of Class (var/let)
class Creature {
    let what: String
    let location: GeoLocation
//    let latitude: Double
//    let longitude: Double

    // Initializer of all variables in the Class for it to exist
    init(what: String, latitude: Double, longitude: Double) {
        self.what = what
        self.GeoLocation = GeoLocation
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
}

// Class Inheritance
class historyCreature: Creature { // Declare Class to Inherit from Super Class
    let year: Int

    init(what: String, year: Int, latitude: Double, longitude: Double)
    {
        self.year = year // Extra Fields not initialised by Super Class so must be given a Class Designated Initializer
        let location = GeoLocation(latitude: latitude, longitude: longitude)
        super.init(what: what, location: location) // Class Designated Initializer at end of method initializes fields declared in this class and then must call its Super Class Designated Initializer (not a Convenience Initializer). Super Class is not aware of other fields declared in Sub Classes so cannot overwrite them
    }
}

class protectedCreature: Creature {
    let protected: String
    
    init(what: String, protected: String, latitude: Double, longitude: Double)
    {
        self.protected = protected
        let location = GeoLocation(latitude: latitude, longitude: longitude)
        super.init(what: what, location: location)
    }
}

class taggedCreature: Creature {
    let tag: String
    
    init(tag: String, latitude: Double, longitude: Double) {
        self.tag = tag
        let location = GeoLocation(latitude: latitude, longitude: longitude)
        super.init(what: tag + " (tag id)", location: location)
    }
}



