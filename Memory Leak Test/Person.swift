//
//  Person.swift
//  Memory Leak Test
//
//  Created by LS on 22/08/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation

class Person {
    let name: String
    private let actionClosure: (() -> ())!

    init(name: String) {

        self.name = name

        actionClosure = {
            () -> () in
            print("I am \(self.name)")
        }
    }

    func performAction() {
        actionClosure()
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}