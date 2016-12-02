//
//  NewBloodPressureViewController.swift
//  MedicalMinder
//
//  Created by Derrick Price on 10/15/16.
//  Copyright © 2016 DLP. All rights reserved.
//

import UIKit
import CoreData

class NewBloodPressureViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var systolicText: UITextField!
    @IBOutlet weak var diastolicText: UITextField!
    
    // Usual setup
    override func viewDidLoad() {
        super.viewDidLoad()

        
        systolicText.delegate = self
        diastolicText.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Force only numbers in the text field
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = NSCharacterSet(charactersInString: "0123456789").invertedSet
        return string.rangeOfCharacterFromSet(invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    @IBAction func saveSettings(sender: UIButton) {
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
