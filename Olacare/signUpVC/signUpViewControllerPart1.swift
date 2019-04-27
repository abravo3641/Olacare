
import UIKit

class signUpViewControllerPart1: UIViewController {

    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmedPassword: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    
    var user:userTemplate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
        
    }
    
    func validate() {
        //To do: Validate
        user = buildUser()
    }
    
    func buildUser() -> userTemplate {
        let u = userTemplate()
        u.email = emailAddress.text!
        u.password = password.text!
        u.firstName = firstName.text!
        u.lastName = lastName.text!
        
        let date = birthdayDatePicker.date
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "dd-MM-YYYY"
        dateFormatter.dateFormat = "YYYY"
        let birthdayYear = Int(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "MM"
        let birthdayMonth = Int(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "dd"
        let birthdayDay = Int(dateFormatter.string(from: date))
        
        let date_obj = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date_obj)
        let age = year - birthdayYear!
        
        u.birthMonth = birthdayMonth!
        u.birthDay = birthdayDay!
        u.birthYear = birthdayYear!
        u.age = age
        return u
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondSignUpWindow" {
            validate()
            let secondSingUpVC = segue.destination as! signUpViewControllerPart2
            secondSingUpVC.user = user
        }
    }
    
    
    @IBAction func onClick(_ sender: Any) {
        view.endEditing(true)
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
