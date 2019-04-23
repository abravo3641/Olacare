

import UIKit

class homeViewController: UIViewController {
    
    var user:userTemplate!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seeDoctorsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.printUser()
        updateUI()
    }
    

    @IBAction func logoutPressed(_ sender: Any) {
        let loggingVc = storyboard?.instantiateViewController(withIdentifier: "loggingNavigation") as! LoginNavigationController
        present(loggingVc, animated: true, completion: nil)
    }
    
    @IBAction func seeDoctorsPressed(_ sender: Any) {
    }
    
    func updateUI() {
        nameLabel.text = user.firstName
        seeDoctorsButton.layer.cornerRadius = 10
    }
    
    
    

}
