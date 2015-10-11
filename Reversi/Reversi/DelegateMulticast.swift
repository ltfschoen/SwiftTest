//
//  DelegateMulticast.swift
//  Reversi
//
//  Created by LS on 11/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation

// Multicasing Pattern (Event)
class DelegateMulticast<T> {

    /* Array of delegates using parameter T to ensure delegate conformance to correct protocol
    */
    private var delegates = [T]()

    // Add delegate to array of Observers
    func addDelegate(delegate: T) {

        // Object acting as delegate of accesssory
        delegates.append(delegate)
    }

    // Invoke the function for each delegate
    func invokeDelegates(invocation: (T) -> ()) {

        for delegate in delegates {

            // Receiver's invocation object
            invocation(delegate)
        }
    }
}