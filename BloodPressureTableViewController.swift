//
//  BloodPressureTableViewController.swift
//  MedicalMinder
//
//  Created by Derrick Price on 9/15/16.
//  Copyright © 2016 DLP. All rights reserved.
//

import UIKit
import CoreData

class BloodPressureTableViewController: UITableViewController {

    var bloodPressures = [BloodPressure]()
    var temporaryContext: NSManagedObjectContext!
    
    // Usual setup
    override func viewDidLoad() {
        let sharedContext = CoreDataStackManager.sharedInstance().managedObjectContext
        
        // Set the temporary context
        temporaryContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        temporaryContext.persistentStoreCoordinator = sharedContext.persistentStoreCoordinator
        
        // Button for adding new entry 
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewBloodPressure")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Table View Delegate and Data Source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the # of perscriptions
        return bloodPressures.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellReuseId = "BloodPressureCell"
        let bloodpressure = bloodPressures[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseId)!
        
        cell.textLabel!.text = bloodpressure.dateTaken.description
        
        // TODO: What about the readings?
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // TODO: Handles selecting the row in the table
        
        let bloodpressure = bloodPressures[indexPath.row]
        
        // Alert the delegate
        //        delegate?.actorPicker(self, didPickActor: actor)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //delete the selected row from table and meme storage
        //        if editingStyle == UITableViewCellEditingStyle.Delete {
        //            memes.removeAtIndex(indexPath.row)
        //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        //
        //            // update the central meme storage & coredata
        //            let object = UIApplication.sharedApplication().delegate
        //            let appDelegate = object as! AppDelegate
        //            sharedContext.deleteObject(appDelegate.memes.removeAtIndex(indexPath.row))
        //            CoreDataStackManager.sharedInstance().saveContext()
        //
        //            // if we have removed all: return to the edit view
        //            if self.memes.count == 0 { self.dismissViewControllerAnimated(true, completion: nil) }
        //        }
    }
    
    
    
    // Action for adding new blood pressure entry
    func addNewBloodPressure() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("NewBloodPressureViewID") as! NewBloodPressureViewController
                
        self.presentViewController(controller, animated: true, completion: nil)
    }
    @IBAction func addNewBloodPressure(sender: UIButton) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("NewBloodPressureViewID") as! NewBloodPressureViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
}