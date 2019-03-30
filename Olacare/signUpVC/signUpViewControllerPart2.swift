

import UIKit

class signUpViewControllerPart2: UIViewController {
    
    var user:userTemplate!

    override func viewDidLoad() {
        super.viewDidLoad()
        //printUser()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "thirdSignUpWindow" {
            let thirdSingUpVC = segue.destination as! signUpViewControllerPart3
            thirdSingUpVC.user = user
        }
    }
    
}

