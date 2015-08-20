//
//  MasterViewController.swift
//  FlickrSearch
//
//  Created by LS on 18/08/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    /* OrderedDictionary holding searches the user submits to Flickr that maps String (search term) to either an array of Flickr.Photo or photos returned from Flickr API. Type Parameter Key-Value Pair are KeyType and ValueType.
        Photo Class is inside the Flickr Class so namespace has period between
    */
    var searches = OrderedDictionary<String, [Flickr.Photo]>()

//      REDUNDANT CODE
//
//    var detailViewController: DetailViewController? = nil
//    var objects = [AnyObject]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
//        if let split = self.splitViewController {
//            let controllers = split.viewControllers
//            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        }
//    }

    // Deleting searches
    override func viewWillAppear(animated: Bool) {

//      REDUNDANT CODE
//        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed

        super.viewWillAppear(animated)
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
        // Add nav bar button to toggle between Done and Edit state in view controller
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    // Changes the table view to the Edit state
    override func setEditing(editing: Bool, animated: Bool)  {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }

//      REDUNDANT CODE
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func insertNewObject(sender: AnyObject) {
//        objects.insert(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }

    // MARK: - Segues

    // Method shows photos after user makes a search and then taps one of the searches
    override func prepareForSegue(segue: UIStoryboardSegue,
                                  sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                /* Retrieve Key/Value for a row using the subscript by index to access the searches Ordered Dictionary but uses an underscore instead of using the Key (search term) since this part of the tuple does not need to be bound to a local variable
                */
                let (_, photos) = self.searches[indexPath.row]
                (segue.destinationViewController as DetailViewController).photos = photos

//      REDUNDANT CODE
//                let object = objects[indexPath.row] as! NSDate
//                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
            }
        }
    }

}

extension MasterViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Ordered Dictionary used to tell Table View the quantity of its rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searches.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        /* Dequeue a call from UITableView and cast it to UITableViewCell since dequeueReusableCellWithIdentifier returns AnyObject (id in Objective-C) instead as Apple APIs do not take advantage of Generics
        */
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        // Retrieve Key/Value for a row using the subscript by index
        let (term, photos) = self.searches[indexPath.row]
        // Set the cell text label and return the cell
        cell.textLabel.text = "\(term) (\(photos.count))"

//      REDUNDANT CODE
//        let object = objects[indexPath.row] as! NSDate
//        cell.textLabel!.text = object.description

        return cell
    }

//      REDUNDANT CODE
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }

    /* Delete searches from Ordered Dictionary when user deletes row by swiping left and updates the table view
    */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.searches.removeAtIndex(indexPath.row)
//      REDUNDANT CODE
//            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}

extension MasterViewController: UISearchBarDelegate {

    // Method called when user taps on search button to search for images
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {

        // Dismiss keyboard by resigning the search bar as first responder
        searchBar.resignFirstResponder()

        // Use the Flickr Class to search for the search term text in the search bar
        let searchTerm = searchBar.text

        /* Flickr search method takes the search term and closure (taking an enumeration parameter of either Error or Results) to execute on success or failure of the search
        */
        Flickr.search(searchTerm) {
            // Parameter
            switch ($0) {
            // Error results in no action
            case .Error:
                break
            /* Success results in the results of the search being returned as the associated value in SearchResults enum type
            */
            case .Results(let results):
                /* Add results to top of Ordered Dictionary with search term as key or if the search term already exists then shift search term to top of list and update it with the latest results
                */
                self.searches.insert(results,
                                     forKey: searchTerm,
                                     atIndex: 0)

                // Reload the Table View with the new or updated data
                self.tableView.reloadData()
            }
        }
    }

}