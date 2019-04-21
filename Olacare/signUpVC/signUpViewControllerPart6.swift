//
//  signUpViewControllerPart6.swift
//  Olacare
//
//  Created by Anthony Bravo on 4/20/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit

class signUpViewControllerPart6: UIViewController {

    var user:userTemplate!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var servicesButton: UIButton!
    @IBOutlet weak var insurenceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    func updateUI() {
        servicesButton.layer.cornerRadius = 10
        insurenceButton.layer.cornerRadius = 5
        nameLabel.text = user.firstName
    }
    
    
    @IBAction func servicesClicked(_ sender: Any) {
        performSegue(withIdentifier: "servicesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "servicesSegue" {
            let testingNavigation = segue.destination as! testingNavigationController
            let homeVC = testingNavigation.children[0] as! homeViewController
            homeVC.user = user
        }
        
        if segue.identifier == "insuranceSegue" {
            let insuranceVC = segue.destination as! insuranceViewController
            insuranceVC.user = user
        }
    }
    
    @IBAction func insurenceButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "insuranceSegue", sender: self)
    }
    
    
    
}
