

import UIKit
import AlamofireImage
import SwiftyStarRatingView

class moreInfoDoctorViewController: UIViewController {

    @IBOutlet weak var innerView: UIView!
    var doctor:doctorTemplate!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorImageView: UIImageView!
    
    @IBOutlet weak var rainbowStamp: UIImageView!
    
    @IBOutlet weak var starView: SwiftyStarRatingView!
    
    
    @IBOutlet weak var servicesLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var bioLabel: UILabel!
    
    
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var languagesLabel: UILabel!
    
    @IBOutlet weak var insuranceIdLabel: UILabel!
    
    
    @IBOutlet weak var certificationIDLabel: UILabel!
    
    
    @IBOutlet weak var educationLabel: UILabel!
    
    
    @IBOutlet weak var appointmentButton: UIButton!
    
    @IBOutlet weak var commentsButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        appointmentButton.layer.cornerRadius = 10
        commentsButton.layer.cornerRadius = 10
    }
    
    func updateUI() {
        setGradient()
        doctorNameLabel.text = "\(doctor.firstName) \(doctor.lastName)"
        let url = URL(string: doctor.profileImg)!
        doctorImageView.af_setImage(withURL: url)
        //Rainbow stamp
        rainbowStamp.isHidden = (doctor.verified) ? false:true
        //star Rating
        starView.value = CGFloat(doctor.rating)
        //Sevices label
        servicesLabel.text = "\(doctor.servicesSpecialties[0])  \(doctor.servicesSpecialties[1])"
        //Locaiton label
        locationLabel.text = doctor.address
        //More info label
        bioLabel.text = doctor.bio
        //Contact Label
        contactLabel.text = doctor.phoneNumber
        //Language Label
        languagesLabel.text = doctor.languages
        insuranceIdLabel.text = doctor.insuranceID
        certificationIDLabel.text = doctor.certification
        educationLabel.text = doctor.education
    }
    
    func setGradient() {
        var gradientLayer:CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = innerView.bounds
        let topColor = hexStringToUIColor(hex: "B6FBFF")
        let bottomColor = hexStringToUIColor(hex: "83A4D4")
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x:0,y:0)
        gradientLayer.endPoint = CGPoint(x:1,y:1)
        innerView.layer.insertSublayer(gradientLayer, at: 0)
        //self.view.layer.insertSublayer(gradientLayer, at: 0)
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
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        let loggingVc = storyboard?.instantiateViewController(withIdentifier: "loggingNavigation") as! LoginNavigationController
        present(loggingVc, animated: true, completion: nil)
    }
    
}
