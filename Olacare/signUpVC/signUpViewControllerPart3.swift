//
//  signUpViewControllerPart3.swift
//  Olacare
//
//  Created by Anthony Bravo on 3/29/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit
import M13Checkbox

class signUpViewControllerPart3: UIViewController {

    var user:userTemplate!
    
    @IBOutlet weak var firstGender: M13Checkbox!
    @IBOutlet weak var secondGender: M13Checkbox!
    @IBOutlet weak var thirdGender: M13Checkbox!
    @IBOutlet weak var fourthGender: M13Checkbox!
    @IBOutlet weak var fifthGender: M13Checkbox!
    @IBOutlet weak var sixthGender: M13Checkbox!
    @IBOutlet weak var seventhGender: M13Checkbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fourthSignUpWindow" {
            saveGenders()
            let fourthSingUpVC = segue.destination as! signUpViewControllerPart4
            fourthSingUpVC.user = user
        }
    }
    
    //Save Pronouns to user
    func saveGenders() {
        let keys:[String] = ["female","trans-female","male","trans-male","non-binary","gender-queer","gender-fluid"]
        let value:[Bool] = checkStatus()
        let genderValues:[String:Any] = [keys[0]:value[0],keys[1]:value[1],keys[2]:value[2],keys[3]:value[3],keys[4]:value[4],keys[5]:value[5],keys[6]:value[6]]
        user.genderValues = genderValues
        
    }
    
    func checkStatus()->[Bool] {
        var result:[Bool] = [false,false,false,false,false,false,false]
        //Checking if genders got checked
        if firstGender.checkState.rawValue == "Checked" {
            result[0] = true
        }
        if secondGender.checkState.rawValue == "Checked" {
            result[1] = true
        }
        if thirdGender.checkState.rawValue == "Checked" {
            result[2] = true
        }
        if fourthGender.checkState.rawValue == "Checked" {
            result[3] = true
        }
        if fifthGender.checkState.rawValue == "Checked" {
            result[4] = true
        }
        if sixthGender.checkState.rawValue == "Checked" {
            result[5] = true
        }
        if seventhGender.checkState.rawValue == "Checked" {
            result[6] = true
        }
        
        return result
    }

}
