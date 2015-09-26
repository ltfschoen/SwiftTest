//
//  FreeWifiHotspotViewController.swift
//  FreeWifiSearch
//
//  Created by LS on 16/09/2015.
//  Copyright © 2015 LS. All rights reserved.
//

// Progress: Page 200

import UIKit

/* Custom Protocol that objects may conform with to be told when user wants to dismiss the FreeWifiHotspot Detailed View.
*/
@objc protocol FreeWifiHotspotControllerDelegate {

    // Optional Method informs Compiler that method not need to be defined
    optional func freeWifiHotspotViewControllerDidFinish(
        viewController: FreeWifiHotspotViewController)
}

class FreeWifiHotspotViewController: UIViewController {

    /* Declare Optional Property with 'weak' Reference (only valid for Classes, not Structs that are value types) for delegate to avoid Retain Cycles between two objects
    */
    weak var delegate: FreeWifiHotspotControllerDelegate?

    @IBOutlet var imageView: UIImageView! // Strong
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!

    // Define Variable of Optional Type to hold the FreeWifiHotspot of the View Controller
    var freeWifiHotspot: FreeWifiHotspot? {
        /* Setup Variable On-Change Listener to detect when the Variable Changes (to allow View Controller to be setup with the current FreeWifiHotspot). "willSet" is called just before variable is set to new value. "didSet" is called just after variable is set to new value.
        */
        didSet {
            self.setupWithFreeWifiHotspot()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Perform Setup when the View Loads (in addition On-Change) before IBOutlets loaded
        self.setupWithFreeWifiHotspot()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupWithFreeWifiHotspot() {

        // IBOutlet Properties are implicitely unwrapped Optionals that are only setup with values after View Loaded
        if !self.isViewLoaded() {
            return
        }

        // Check that a freeWifiHotspot actually exists before proceeding to setup the view
        if let freeWifiHotspot = self.freeWifiHotspot {

            self.title = freeWifiHotspot.name

            self.nameLabel.text = freeWifiHotspot.name
            self.cityLabel.text = freeWifiHotspot.city

            // Load picture of the freeWifiHotspot using NSURLConnection
            let request = NSURLRequest(URL: freeWifiHotspot.pictureURL)

            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                let image = UIImage(data: data!)
                self.imageView.image = image
            })
        }
    }

    @IBAction private func back(sender: AnyObject) {

        /* Optional Chaining calls Delegate Method to inform it is finished (unless Delegate Property is nil or does not implement freeWifiHotspotViewControllerDidFinish)
        */
        self.delegate?.freeWifiHotspotViewControllerDidFinish?(self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
