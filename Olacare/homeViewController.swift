

import UIKit

class homeViewController: UIViewController {
    
    var user:userTemplate!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.printUser()
        updateUI()
    }
    

    @IBAction func logoutPressed(_ sender: Any) {
        let loggingVc = storyboard?.instantiateViewController(withIdentifier: "loggingNavigation") as! LoginNavigationController
        present(loggingVc, animated: true, completion: nil)
    }
    
    func updateUI() {
        nameLabel.text = user.firstName
        
    }
    

}
