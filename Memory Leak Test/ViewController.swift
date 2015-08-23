//
//  ViewController.swift
//  Memory Leak Test
//
//  Created by LS on 22/08/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create a Person Class Instance and assign to Constant
        let person = Person(name: "Luke")
        
        // Invoke a Person Class Method
        person.performAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}