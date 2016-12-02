//
//  PersonalInfoViewController.swift
//  MedicalMinder
//
//  Created by Derrick Price on 8/17/16.
//  Copyright © 2016 DLP. All rights reserved.
//

import UIKit
import CoreData

protocol PersonalInfoViewControllerDelegate {
    func patientPicker(patientPicker: PersonalInfoViewController, didPickPatient patient: Patient?)
}

/**
* Challenge Step 3: Convert Actor Picker to Fetched Results View Controller.
*/

class PersonalInfoViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    var delegate: PersonalInfoViewControllerDelegate?
    var searchTask: NSURLSessionDataTask?
    var temporaryContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        
        let sharedContext = CoreDataStackManager.sharedInstance().managedObjectContext
        
        // Set the temporary context
        temporaryContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        temporaryContext.persistentStoreCoordinator = sharedContext.persistentStoreCoordinator
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.searchBar.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        self.delegate?.patientPicker(self, didPickPatient: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Each time the search text changes we want to cancel any current download and start a new one
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Cancel the last task
        if let task = searchTask {
            task.cancel()
        }
        
        // If the text is empty we are done
        if searchText == "" {
            actors = [Person]()
            tableView?.reloadData()
            objc_sync_exit(self)
            return
        }
        
        // Start a new one download
        let resource = TheMovieDB.Resources.SearchPerson
        let parameters = ["query" : searchText]
        
        searchTask = TheMovieDB.sharedInstance().taskForResource(resource, parameters: parameters) { [unowned self] jsonResult, error in
            
            // Handle the error case
            if let error = error {
                print("Error searching for actors: \(error.localizedDescription)")
                return
            }
            
            // Get a Swift dictionary from the JSON data
            if let actorDictionaries = jsonResult.valueForKey("results") as? [[String : AnyObject]] {
                self.searchTask = nil
                
                // Create an array of Person instances from the JSON dictionaries
                self.actors = actorDictionaries.map() {
                    Person(dictionary: $0, context: self.temporaryContext)
                }
                
                // Reload the table on the main thread
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView!.reloadData()
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellReuseId = "ActorSearchCell"
        let actor = actors[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseId)!
        
        configureCell(cell, actor: actor)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let patient = actors[indexPath.row]
        
        // Alert the delegate
        delegate?.actorPicker(self, didPickPatient: patient)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // All right, this is kind of meager. But its nice to be consistent
    func configureCell(cell: UITableViewCell, actor: Person) {
        cell.textLabel!.text = actor.name
    }
}
