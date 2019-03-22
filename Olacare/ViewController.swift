//
//  ViewController.swift
//  Olacare
//
//  Created by Anthony Bravo on 3/21/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = Database.database().reference()
    }


}

