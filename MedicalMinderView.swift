//
//  HomeView.swift
//  MedicalMinder
//
//  Created by Derrick Price on 9/4/16.
//  Copyright © 2016 DLP. All rights reserved.
//


import UIKit

class MedicalMinderView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        navigationItem.title = nil
    }
    
    @IBAction func BloodPressure(sender: UIButton) {
    }
    
    @IBAction func DoctorButton(sender: UIButton) {
    }

    @IBAction func MedicinesButton(sender: UIButton) {
    }

    @IBAction func UserInfoButton(sender: UIButton) {
        
        // Launch the User Information page
//        performSegueWithIdentifier("UserInformationViewID", sender: self)
    }
}