//
//  LaunchViewController.swift
//  Olacare
//
//  Created by Anthony Bravo on 4/21/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    
    @IBOutlet weak var logoImg: UIImageView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.0, animations: {
            self.logoImg.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
        }) {(success) in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
    }

}
