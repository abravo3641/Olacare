//
//  signUpViewControllerPart5.swift
//  Olacare
//
//  Created by Anthony Bravo on 4/20/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit
import Firebase
import M13Checkbox

class signUpViewControllerPart5: UIViewController {
    
    var user:userTemplate!
    let group = DispatchGroup()
    var success:[Bool] = [false,false,false,false,false] //Array that holds results from writing to database

    
    //Sexual Orientation
    @IBOutlet weak var firstOrientation: M13Checkbox!
    @IBOutlet weak var secondOrientation: M13Checkbox!
    @IBOutlet weak var thirdOrientation: M13Checkbox!
    @IBOutlet weak var fourthOrientation: M13Checkbox!
    @IBOutlet weak var fifthOrientation: M13Checkbox!
    @IBOutlet weak var sixthOrientation: M13Checkbox!
    
    //Sexual Activity
    @IBOutlet weak var firstActivity: M13Checkbox!
    @IBOutlet weak var secondActivity: M13Checkbox!
    @IBOutlet weak var thirdActivity: M13Checkbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()

    }
    @IBAction func submitClicked(_ sender: Any) {
        saveSexualActivity()
        saveSexualOrientation()
        createUserInDatabase(user: user)
        
    }

    
    func saveSexualOrientation() {
        let keys:[String] = ["gay","lesbian","bisexual","pansexual","queer","polysexual"]
        let values:[Bool] = sexualOrientationStatus()
        let sexualOrientationValues:[String:Any] = [keys[0]:values[0],keys[1]:values[1],keys[2]:values[2],keys[3]:values[3],keys[4]:values[4],keys[5]:values[5]]
        user.sexualOrientationValues = sexualOrientationValues
    }
    
    func saveSexualActivity() {
        let keys:[String] = ["female","male","intersex"]
        let values:[Bool] = sexualActivityStatus()
        let sexualActivitiesValues:[String:Any] = [keys[0]:values[0],keys[1]:values[1],keys[2]:values[2]]
        user.sexualActivitiesValues = sexualActivitiesValues
    }
    
    func sexualOrientationStatus() -> [Bool] {
        var result:[Bool] = [false,false,false,false,false,false]
        //Checking if Sexual Orientation got clicked
        if firstOrientation.checkState.rawValue == "Checked" {
            result[0] = true
        }
        if secondOrientation.checkState.rawValue == "Checked" {
            result[1] = true
        }
        if thirdOrientation.checkState.rawValue == "Checked" {
            result[2] = true
        }
        if fourthOrientation.checkState.rawValue == "Checked" {
            result[3] = true
        }
        if fifthOrientation.checkState.rawValue == "Checked" {
            result[4] = true
        }
        if sixthOrientation.checkState.rawValue == "Checked" {
            result[5] = true
        }
        return result
    }
    
    func sexualActivityStatus() -> [Bool] {
        var result:[Bool] = [false,false,false]
        if firstActivity.checkState.rawValue == "Checked" {
            result[0] = true
        }
        if secondActivity.checkState.rawValue == "Checked" {
            result[1] = true
        }
        if thirdActivity.checkState.rawValue == "Checked" {
            result[2] = true
        }
        
        return result
    }
    
    
    func createUserInDatabase(user:userTemplate) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
            if error != nil {
                print("Error Creating User: ", error?.localizedDescription as Any)
            }
            else {
                //Create user values on Database
                let uid = result?.user.uid
                user.uid = uid!
                let values = ["email":user.email, "password":user.password, "firstName":user.firstName, "lastName":user.lastName, "birthMonth":user.birthMonth, "birthDay":user.birthDay, "birthYear":user.birthYear, "age":user.age, "birthSex":user.sex, "transitioned":user.transitioned, "uid":user.uid] as [String : Any]
                self.createOuterProfile(values: values, uid: uid!)
                self.createInnerValues(values: user.pronounValues, uid: uid!,inner: "pronouns",index: 1)
                self.createInnerValues(values: user.genderValues, uid: uid!, inner: "genders", index: 2)
                self.createInnerValues(values: user.sexualOrientationValues, uid: uid!, inner: "sexualOrientation", index: 3)
                self.createInnerValues(values: user.sexualActivitiesValues, uid: uid!, inner: "sexualActivities", index: 4)
                
                //Only runs when all database calls have been made
                self.group.notify(queue: .main) {
                    var sucessfulCreation:Bool = true //Assumetrue
                    //If one of the errors on the array is false then sucessfulCreation is false
                    for element in self.success {
                        sucessfulCreation = (element) ? true : false
                    }
                    if sucessfulCreation {
                        //Go to next screen
                        self.performSegue(withIdentifier: "submitCheck", sender: self)
                    }
                    else {
                        //Handle Error
                    }
                }
            }
        }
    }
    
    //Outer most layer of user profile on database. Returns true if successful
    func createOuterProfile(values:[String:Any], uid:String){
        group.enter()
        Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print("Error Creating User", error?.localizedDescription as Any)
            }
            else {
                print("Succesfully created user on the Database!")
                self.success[0] = true
            }
            self.group.leave()
        })
        
    }
    
    //Index is the index that we will write to our sucess array
    func createInnerValues(values:[String:Any], uid:String, inner:String, index:Int) {
        group.enter()
        Database.database().reference().child("users").child(uid).child(inner).updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print("Error Creating Pronouns for User", error?.localizedDescription as Any)
            }
            else {
                print("Succesfully created Inner value: \(inner) for user!")
                self.success[index] = true
            }
            self.group.leave()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submitCheck" {
            let sixthSingUpVC = segue.destination as! signUpViewControllerPart6
            sixthSingUpVC.user = user
        }
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
    
}
