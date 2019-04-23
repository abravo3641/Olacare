//
//  insuranceViewController.swift
//  Olacare
//
//  Created by Anthony Bravo on 4/21/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit
import Firebase

class insuranceViewController: UIViewController {

    var user:userTemplate!
    let group = DispatchGroup()
    
    @IBOutlet weak var insuranceName: UITextField!
    @IBOutlet weak var insuranceID: UITextField!
    @IBOutlet weak var skipLoginButton: UIButton!
    @IBOutlet weak var submitButtom: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    

    @IBAction func skipClicked(_ sender: Any) {
        performSegue(withIdentifier: "insurenceSubmitted", sender: self)
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if checkFields() {
            saveInsurance()
            //Runs when we save insurance on Database
            group.notify(queue: .main) {
                self.performSegue(withIdentifier: "insurenceSubmitted", sender: self)
            }
        }
        else {
            //Handle empty fields error
            print("Empty!")
        }
    }
    func checkFields() -> Bool {
        var result = true
        if insuranceName.text! == "" || insuranceID.text! == "" {
            result = false
        }
        return result
    }
    
    func saveInsurance() {
        user.insuranceName = insuranceName.text!
        user.insuranceID = insuranceID.text!
        let values = ["insuranceName":user.insuranceName, "insuranceID":user.insuranceID]
        group.enter()
        Database.database().reference().child("users").child(user.uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print("Error Creating User", error?.localizedDescription as Any)
            }
            else {
                print("Succesfully created user on the Database!")
            }
            self.group.leave()
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "insurenceSubmitted" {
            let testingNavigation = segue.destination as! testingNavigationController
            let homeVC = testingNavigation.children[0] as! homeViewController
            homeVC.user = user
        }
    }
    
    func updateUI() {
        skipLoginButton.layer.cornerRadius = 10
        submitButtom.layer.cornerRadius = 10
    }
}
