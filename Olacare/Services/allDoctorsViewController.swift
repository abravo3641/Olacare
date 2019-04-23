//
//  allDoctorsViewController.swift
//  Olacare
//
//  Created by Anthony Bravo on 4/21/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit

class allDoctorsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutPressed(_ sender: Any) {
        let loggingVc = storyboard?.instantiateViewController(withIdentifier: "loggingNavigation") as! LoginNavigationController
        present(loggingVc, animated: true, completion: nil)
    }
    
}
