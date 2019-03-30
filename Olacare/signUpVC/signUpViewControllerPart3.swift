//
//  signUpViewControllerPart3.swift
//  Olacare
//
//  Created by Anthony Bravo on 3/29/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit

class signUpViewControllerPart3: UIViewController {

    var user:userTemplate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fourthSignUpWindow" {
            let fourthSingUpVC = segue.destination as! signUpViewControllerPart4
            fourthSingUpVC.user = user
        }
    }

}
