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

    init(fbid: String, name: String, location: CLLocationCoordinate2D) {
        self.fbid = fbid
        self.name = name
        self.location = location
        
        /* MKAnnotation inherits from Super Class called NSObjectProtocol and so NSObject's initializer must also be called as well as FreeWifi Object
        */
        super.init()
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