//
//  signUpViewControllerPart4.swift
//  Olacare
//
//  Created by Anthony Bravo on 3/29/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit

class signUpViewControllerPart4: UIViewController {

    var user:userTemplate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func printUser() {
        print("\nUser created: \n   email = \(user.email) \n   password: \(user.password) \n   name: \(user.firstName) \(user.lastName) \n   birthday: \(user.birthMonth)/\(user.birthDay)/\(user.birthYear) \n   Age: \(user.age)")
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        printUser()
    }
    
}
