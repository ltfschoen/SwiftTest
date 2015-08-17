//
// GeoLocation.swift
//  
//
// Created by LS on 14/08/2015.
//
// Progress: Page 73/XX (Ch3) / 257

import MapKit

// Struct used as an Encapsulation Type to hold Data for common units of information
struct GeoLocation {
    var latitude: Double
    var longitude: Double
    // Distance of users current location from the specified location using Core Location
    func distanceBetween(other: GeoLocation) -> Double {
        let locationA = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let locationB = CLLocation(latitude: other.latitude, longitude: other.longitude)
        return locationA.distanceFromLocation(locationB)
    }
}

/*  Struct Extension (without conformance to any protocol) to separate Logical Units of code. MapKit (GeoLocation) code is kept separate by use of two Computed Properties (Helpers) that return coordinates and point in MKMapView coordinate space
*/
extension GeoLocation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }

    var mapPoint: MKMapPoint {
        return MKMapPointForCoordinate(self.coordinate)
    }
}

/* Extension for Operator Overloads. Declare Operator Overload in global scope (since not methods that belong to a class and == operator may be used anywhere)
*/
extension GeoLocation: Equatable {
}

/* Implementation of Operator Overload that checks equality between latitude and longtitude. The type of the two parameters are instances of the class being compared (GeoLocation)
*/
func ==(lhs: GeoLocation, rhs: GeoLocation) -> Bool {
    return lhs.latitude == rhs.latitude &&
           lhs.longitude == rhs.longitude
}