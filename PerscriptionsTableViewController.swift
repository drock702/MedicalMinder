//
//  PerscriptionsTableViewController.swift
//  MedicalMinder
//
//  Created by Derrick Price on 9/13/16.
//  Copyright © 2016 DLP. All rights reserved.
//

import UIKit
import CoreData


class PerscriptionsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var perscriptions: [Perscription]!
    @IBOutlet var perscriptionsTableView: UITableView!

    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadCachedPerscriptionData ()
        
        // retrieve the perscriptions stored in AppDelegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        perscriptions = appDelegate.perscriptions
        self.tableView.reloadData()
    }    
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "Perscription")
        fetchRequest.sortDescriptors = []
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
        }()
    
    
    func loadCachedPerscriptionData ()
    {
        dispatch_async(dispatch_get_main_queue()) {
            print ("loadCachedPerscriptionData")

            for med in self.fetchAllPerscriptions() {
                
            }
        }
        
    }
    
    // Retrieve the cached perscriptions
    func fetchAllPerscriptions() -> [Perscription] {
        
        print ("Call fetchAllPerscriptions!!\n\n")
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Perscription")
        //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Execute the Fetch Request
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [Perscription]
        } catch _ {
            return [Perscription]()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the # of perscriptions
        return self.perscriptions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PerscriptionCell", forIndexPath: indexPath) as! PerscriptionTableViewCell
        let perscription = self.perscriptions[indexPath.row]
        
        print ("Tableview at cell row at index path")
        
        // TODO: Set up an image for the blood pressure right arrow?
        cell.medicineImageView.image = UIImage(named: "medicineFrame")
        cell.medicineNameLabel?.text = perscription.name
        cell.medicineDescriptionLabel?.text = perscription.overview
        cell.medicineDosageLabel?.text = (perscription.dosage_number.description) + " " + (perscription.dosage_units?.lowercaseString)! + " every " + (perscription.dosage_time?.description)!
        
        // Set the components for the perscription
//        cell.textLabel?.text = perscription.topText + "..." + perscription.bottomText
//        cell.imageView?.image = UIImage(data: meme.memedImageBin)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print ("tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) called")
        
        // TODO: Handles selecting the row in the table
        
        // show the details of the selected row
//        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as! MemeDetailViewController
//        
//        detailController.meme = self.memes[indexPath.row]
//        // don't show the tabbar in the detailview
//        detailController.hidesBottomBarWhenPushed = true
//        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        print ("tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) called")
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
}