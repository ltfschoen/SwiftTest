//
//  FreeWifi.swift
//  FreeWifiSearch
//
//  Created by LS on 13/09/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation

/* Import MapKit to provide Compiler access to MKAnnotations Protocol
*/
import MapKit

/* Class Object Properties to Fetch Data from FB Graph API. Each Class Object instance to be shown as annotations on Map View (enabled through inclusion of an extension to achieve conformance to MKAnnotations Protocol).
*/
class FreeWifiHotspot: NSObject {

    let fbid: String
    let name: String
    let location: CLLocationCoordinate2D
    let city: String

    /* Define Computed Property of NSURL Type pointing to large picture for mandatory Facebook ID (not Optional)
    */
    var pictureURL: NSURL {
        return NSURL(string: "http://graph.facebook.com/place/picture?id=\(self.fbid)" + "&type=large")!
    }

    init(fbid: String, name: String, location: CLLocationCoordinate2D, city: String) {
        self.fbid = fbid
        self.name = name
        self.location = location
        self.city = city
        
        /* MKAnnotation inherits from Super Class called NSObjectProtocol and so NSObject's initializer must also be called as well as FreeWifi Object
        */
        super.init()
    }

    // Parse JSON Data for single Wifi Hotspot and Return a Wifi Hotspot Object if valid
    class func fromJSON(json: [String:JSONValue]) -> FreeWifiHotspot? {

        // Obtain JSON Data parameters using Optional Chaining
        let fbid = json["id"]?.string
        let name = json["name"]?.string
        let latitude = json["location"]?["latitude"]?.double
        let longitude = json["location"]?["longitude"]?.double

        // Check none of the parameters from JSON Data are not parsed as nil (signifying error)
        if fbid != nil && name != nil && latitude != nil && longitude != nil {

            // Create Wifi Hotspot Object
            var city: String
            if let maybeCity = json["location"]?["city"]?.string {
                city = maybeCity
            } else {
                // Use Empty String when no city
                city = ""
            }
            
            let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)

            return FreeWifiHotspot(fbid: fbid!, name: name!, location: location, city: city)
        }
        
        // Return nil when a parameter is missing
        return nil
    }
}

/* Extension to achieve conformance to MKAnnotations Protocol. MKAnnotations Protocol maps 'title' and 'coordinate' Computed Properties to the 'name' and 'location' Properties of the Class Object
*/
extension FreeWifiHotspot: MKAnnotation {

    var title: String! {
        return name
    }

    var coordinate: CLLocationCoordinate2D {
        return location
    }

}