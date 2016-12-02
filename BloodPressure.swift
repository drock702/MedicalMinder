//
//  BloodPressure.swift
//  MedicalMinder
//
//  Created by Derrick Price on 8/17/16.
//  Copyright © 2016 DLP. All rights reserved.
//

import UIKit
import CoreData

class BloodPressure : NSManagedObject {

    struct Keys {
        static let Date = "dateTaken"
        static let Diastolic = "diastolic"
        static let Systolic = "systolic"
    }
    
    @NSManaged var dateTaken: NSDate
    @NSManaged var diastolic: Int
    @NSManaged var systolic: Int
    @NSManaged var patients: [Patient]?
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        // Core Data
        let entity =  NSEntityDescription.entityForName("Doctor", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        // Dictionary
        diastolic = dictionary[Keys.Diastolic] as! Int
        systolic = dictionary[Keys.Systolic] as! Int
        
        // Convert the date
        if let dateString = dictionary[Keys.Date] as? String {
            if let date = MedicalMinderDB.sharedDateFormatter.dateFromString(dateString) {
                dateTaken = date
            }
        }
        
        // TODO: Get the patients????
    }
    
}
