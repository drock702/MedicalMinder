//
//  Perscription.swift
//  MedicalMinder
//
//  Created by Derrick Price on 8/17/16.
//  Copyright © 2016 DLP. All rights reserved.
//

import UIKit
import CoreData

class Perscription : NSManagedObject {

    struct Keys {
        static let Name = "name"
        static let DosageNumber = "dosage_number"
        static let DosageTime = "dosage_time"
        static let DosageUnits = "dosage_units"
        static let Overview = "overview"
        static let Photo = "photo"
        static let StartDate = "start_date"
    }
    
    @NSManaged var name: String
    @NSManaged var dosage_number: NSNumber
    @NSManaged var dosage_time: NSDate?
    @NSManaged var dosage_units: String?
    @NSManaged var overview: String?
    @NSManaged var startDate: NSDate?
    @NSManaged var photo: NSData?
    @NSManaged var patients: [Patient]?
    @NSManaged var doctors: [Doctor]?
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        print ("The ini for the Perscription object - dosage # \(dictionary[Keys.DosageNumber] as? Int)")
        // Core Data
        let entity =  NSEntityDescription.entityForName("Perscription", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        // Dictionary
        name = dictionary[Keys.Name] as! String
        dosage_number = dictionary[Keys.DosageNumber] as! Int
      //  dosage_time = dictionary[Keys.DosageTime] as?
        dosage_units = dictionary[Keys.DosageUnits] as? String
        overview = dictionary[Keys.Overview] as? String
        
        // Get the date
        startDate = dictionary[Keys.StartDate] as? NSDate
        
        
        // TODO: Get the patients and doctors????
    }
    
    // Use this for the photo image??
//    var posterImage: UIImage? {
//        
//        get {
//            return TheMovieDB.Caches.imageCache.imageWithIdentifier(posterPath)
//        }
//        
//        set {
//            TheMovieDB.Caches.imageCache.storeImage(newValue, withIdentifier: posterPath!)
//        }
//    }
}




