

import UIKit

class homeViewController: UIViewController {
    
    var user:userTemplate!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seeDoctorsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //user.printUser()
        updateUI()
        setGradient()
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
