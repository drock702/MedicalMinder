//
//  NewPerscriptionViewController.swift
//  MedicalMinder
//
//  Created by Derrick Price on 11/2/16.
//  Copyright © 2016 DLP. All rights reserved.
//

import UIKit
import CoreData

class NewPerscriptionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var DosageNumTextField: UITextField!
    @IBOutlet weak var UnitsTextField: UITextField!
    @IBOutlet weak var FrequencyTextField: UITextField!
    @IBOutlet weak var StartingDate: UIDatePicker!

    
    // Usual setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateTime = getDateTime ()
        
        DosageNumTextField.delegate = self
        FrequencyTextField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Force only numbers in the text field
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = NSCharacterSet(charactersInString: "0123456789").invertedSet
        return string.rangeOfCharacterFromSet(invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    // Core Data Convenience. This will be useful for fetching. And for adding and saving objects as well.
    lazy var sharedContext: NSManagedObjectContext =  {
        return CoreDataStackManager.sharedInstance().managedObjectContext
        }()
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    @IBAction func saveSettings(sender: UIButton) {
        
        let scriptDictionary: [String : AnyObject] = [
            Perscription.Keys.Name : NameTextField.text!,
            Perscription.Keys.DosageNumber : DosageNumTextField.text!,
            Perscription.Keys.StartDate : StartingDate,
            Perscription.Keys.DosageUnits : UnitsTextField.text!,
            Perscription.Keys.Overview : "Nothing right now"
            //Perscription.Keys.DosageTime : nil
        ]
        
        // Now we create a new Location, using the shared Context
        _ = Perscription(dictionary: scriptDictionary, context: sharedContext)
        
        // Save the settings and exit
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    @IBAction func cancelSettings(sender: UIButton) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    func getDateTime() -> (time: String, date: String) {
        
        let formatter = NSDateFormatter()
        //formatter.timeStyle = NSTimeF
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        let currentDateTime = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour,.Minute,.Second], fromDate: currentDateTime)
        let hour = components.hour
        let min = components.minute
        let sec = components.second
        
        formatter.dateFormat = "MMMM dd, yyyy"
        let convertedDate = formatter.stringFromDate(currentDateTime)
        
        return ("\(hour):\(min):\(sec)", convertedDate)
    }
}
