//
//  signUpViewController.swift
//  Olacare
//
//  Created by Anthony Bravo on 3/22/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit



class signUpViewController: UIViewController {

    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var confirmedEmailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func validate(_ sender: UIButton) {
        let user = createUser()
        print("User created: \n email: \(user.email!) \n password: \(user.password!) \n name: \(user.firstName!) \(user.lastName!) \n birthday: \(user.birthMonth!)/\(user.birthDay!)/\(user.birthYear!)")
    }
    
    func createUser() -> user {
        let date = birthdayDatePicker.date
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "dd-MM-YYYY"
        dateFormatter.dateFormat = "YYYY"
        let birthdayYear = Int(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "MM"
        let birthdayMonth = Int(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "dd"
        let birthdayDay = Int(dateFormatter.string(from: date))
        
        let u = user(email:emailAddress.text!, password: password.text!, firstName: firstName.text!, lastName: lastName.text!, birthMonth: birthdayMonth!, birthDay: birthdayDay!, birthYear: birthdayYear!)
        
        return u
    }
    
    
}
