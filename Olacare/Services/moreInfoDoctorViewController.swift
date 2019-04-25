

import UIKit
import AlamofireImage

class moreInfoDoctorViewController: UIViewController {

    var doctor:doctorTemplate!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        doctorNameLabel.text = "More Info for \(doctor.firstName) \(doctor.lastName)"
        let url = URL(string: doctor.profileImg)!
        doctorImageView.af_setImage(withURL: url)
    }

}
