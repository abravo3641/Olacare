//
//  LoginViewController.swift
//  Olacare
//
//  Created by Anthony Bravo on 3/22/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        //ref.setValue("hello there")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
