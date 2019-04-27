import UIKit
import Firebase
import M13Checkbox

class signUpViewControllerPart4: UIViewController {

    var user:userTemplate!
    //Sex
    @IBOutlet weak var femaleBirth: M13Checkbox!
    @IBOutlet weak var maleBirth: M13Checkbox!
    @IBOutlet weak var intersexBirth: M13Checkbox!
    //Transition
    @IBOutlet weak var yesTransition: M13Checkbox!
    @IBOutlet weak var noTransition: M13Checkbox!
    @IBOutlet weak var inProcessTransition: M13Checkbox!
    @IBOutlet weak var thinkingTransition: M13Checkbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fifthSignUpWindow" {
            saveValues()
            let fifthSingUpVC = segue.destination as! signUpViewControllerPart5
            fifthSingUpVC.user = user
        }
    }
    
    func saveValues() {
        saveSex()
        saveTransition()
    }
    
    func saveSex() {
        if femaleBirth.checkState.rawValue == "Checked" {
            user.sex = "female"
        }
        else if maleBirth.checkState.rawValue == "Checked" {
            user.sex = "male"
        }
        else if intersexBirth.checkState.rawValue == "Checked" {
            user.sex = "intersex"
        }
        else {
            user.sex = "none"
        }
    }
    
    func saveTransition() {
        if yesTransition.checkState.rawValue == "Checked" {
            user.transitioned = "yes"
        }
        else if noTransition.checkState.rawValue == "Checked" {
            user.transitioned = "no"
        }
        else if inProcessTransition.checkState.rawValue == "Checked" {
            user.transitioned = "in Process"
        }
        else if thinkingTransition.checkState.rawValue == "Checked" {
            user.transitioned = "thinking about it"
        }
        else {
            user.transitioned = "none"
        }
    }

    @IBAction func sexBirthClicked(_ sender: M13Checkbox) {
        //Female birth
        if sender.tag == 1 && sender.checkState.rawValue == "Checked" {
            maleBirth.setCheckState(.unchecked, animated: true)
            intersexBirth.setCheckState(.unchecked, animated: true)
        } //Male
        if sender.tag == 2 && sender.checkState.rawValue == "Checked" {
            femaleBirth.setCheckState(.unchecked, animated: true)
            intersexBirth.setCheckState(.unchecked, animated: true)
        } //Inter
        if sender.tag == 3 && sender.checkState.rawValue == "Checked" {
            femaleBirth.setCheckState(.unchecked, animated: true)
            maleBirth.setCheckState(.unchecked, animated: true)
        }
    }
    
    @IBAction func transitionClicked(_ sender: M13Checkbox) {
        //Yes
        if sender.tag == 1 && sender.checkState.rawValue == "Checked" {
            noTransition.setCheckState(.unchecked, animated: true)
            inProcessTransition.setCheckState(.unchecked, animated: true)
            thinkingTransition.setCheckState(.unchecked, animated: true)
        } //No
        if sender.tag == 2 && sender.checkState.rawValue == "Checked" {
            yesTransition.setCheckState(.unchecked, animated: true)
            inProcessTransition.setCheckState(.unchecked, animated: true)
            thinkingTransition.setCheckState(.unchecked, animated: true)
        } //InProcess
        if sender.tag == 3 && sender.checkState.rawValue == "Checked" {
            yesTransition.setCheckState(.unchecked, animated: true)
            noTransition.setCheckState(.unchecked, animated: true)
            thinkingTransition.setCheckState(.unchecked, animated: true)
        } //thinkingAboutit
        if sender.tag == 4 && sender.checkState.rawValue == "Checked" {
            yesTransition.setCheckState(.unchecked, animated: true)
            noTransition.setCheckState(.unchecked, animated: true)
            inProcessTransition.setCheckState(.unchecked, animated: true)
        }
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
