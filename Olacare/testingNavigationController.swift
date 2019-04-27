//
//  testingNavigationController.swift
//  Olacare
//
//  Created by Anthony Bravo on 4/21/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit

class testingNavigationController: UINavigationController {

    @IBOutlet weak var topNavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let colors:[UIColor] = [hexStringToUIColor(hex: "ffffff"),hexStringToUIColor(hex: "dddad7")]
        topNavigationBar.setGradientBackground(colors: colors, startPoint: .bottomLeft, endPoint: .bottomRight)
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




