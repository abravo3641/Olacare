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
    
    
    @IBOutlet weak var topView: UIView!
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
        setGradient()
        setGradientTop()
    }
    func setGradient() {
        var gradientLayer:CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        let topColor = hexStringToUIColor(hex: "B6FBFF")
        let bottomColor = hexStringToUIColor(hex: "83A4D4")
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x:0,y:0)
        gradientLayer.endPoint = CGPoint(x:1,y:1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientTop() {
        var gradientLayer:CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = topView.bounds
        let topColor = hexStringToUIColor(hex: "ffffff")
        let bottomColor = hexStringToUIColor(hex: "dddad7")
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x:0,y:0)
        gradientLayer.endPoint = CGPoint(x:1,y:1)
        //self.view.layer.insertSublayer(gradientLayer, at: 0)
        topView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    @IBAction func onClick(_ sender: Any) {
        view.endEditing(true)
    }
}

