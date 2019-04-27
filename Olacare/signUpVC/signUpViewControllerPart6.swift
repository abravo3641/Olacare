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
        setGradient()

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
