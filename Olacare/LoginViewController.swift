

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user:userTemplate!
    let semaphore = DispatchSemaphore(value: 0)
    let group = DispatchGroup()
    let group1 = DispatchGroup()
    let ref = Database.database().reference()
    var cycle:Bool = false
    @IBOutlet weak var navTitle: UINavigationItem!
    
    override func viewDidLoad() {
        setGradient()
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    
    @IBAction func logInPressed(_ sender: UIButton) {
        let emailText:String = emailTextField.text!
        let passwordText:String = passwordTextField.text!
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { (result, error) in
            if error != nil {
                print("Error Creating User: ", error?.localizedDescription as Any)
            }
            else {
                self.loginSuccessful(uid: (result?.user.uid)!)
            }
        }
        
    }
    
    func loginSuccessful(uid:String)  {
        user = createUser(uid: uid)
        //Waiting for closure to finish before moving to next screen
        group.notify(queue: .main) {
            self.performSegue(withIdentifier: "presentLogin", sender: self)
        }
        
    }
    
    func createUser(uid:String) -> userTemplate {
        let createdUser:userTemplate = userTemplate()
        group.enter()
        let ref = Database.database().reference().child("users").child(uid).observe(.value) { (DataSnapshot) in
            for field in DataSnapshot.children.allObjects as! [DataSnapshot] {
                //Filling right key to make user
                switch field.key {
                    case "uid":
                        createdUser.uid = field.value! as! String
                    case "email":
                        createdUser.email = field.value! as! String
                    case "password":
                        createdUser.password = field.value! as! String
                    case "firstName":
                        createdUser.firstName = field.value! as! String
                    case "lastName":
                        createdUser.lastName = field.value! as! String
                    case "birthMonth":
                        createdUser.birthMonth = field.value! as! Int
                    case "birthYear":
                        createdUser.birthYear = field.value! as! Int
                    case "birthDay":
                        createdUser.birthDay = field.value! as! Int
                    case "age":
                        createdUser.age = field.value! as! Int
                    case "birthSex":
                        createdUser.sex = field.value! as! String
                    case "genders":
                        createdUser.genderValues = field.value as! [String:Any]
                    case "pronouns":
                        createdUser.pronounValues = field.value as! [String:Any]
                    case "sexualActivities":
                        createdUser.sexualActivitiesValues = field.value as! [String:Any]
                    case "sexualOrientation":
                        createdUser.sexualOrientationValues = field.value as! [String:Any]
                    case "transitioned":
                        createdUser.transitioned = field.value! as! String
                    case "insuranceName":
                        createdUser.insuranceName = field.value! as! String
                    case "insuranceID":
                        createdUser.insuranceID = field.value! as! String
                    default:
                        print("Key not found! \(field.key)")
                }
            }
            self.group.leave()
        }
        return createdUser
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentLogin" {
            let testingNavigation = segue.destination as! testingNavigationController
            let homeVC = testingNavigation.children[0] as! homeViewController
            homeVC.user = user
        }
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    //Puts doctor on the all & their type field, so on two fields
    func putDoctorOnDatabase(type:String) {
        let doctor = createDoctor()
        //Only run once our index issue has been solved
        group.notify(queue: .main) {
            let values = ["firstName":doctor.firstName, "lastName":doctor.lastName, "age":doctor.age, "sex":doctor.sex, "phoneNumber":doctor.phoneNumber, "address":doctor.address, "profileImg":doctor.profileImg, "rating":doctor.rating, "verified":doctor.verified, "uid":doctor.uid, "validInsurances":doctor.validInsurances, "servicesSpecialties":doctor.servicesSpecialties ] as [String : Any]
            
            //Putting doctors on all field on Database
            self.ref.child("doctors").child("all").child(String(doctor.uid)).updateChildValues(values)
            

            //Putting doctors on their corresponding Database field
            //self.ref.child("doctors").child(type).child(String(doctor.uid)).updateChildValues(values)
        }
    }
    
    func createDoctor() -> doctorTemplate {
        var doctor = doctorTemplate()
        doctor = updateDataBaseIndex(doctor: doctor)
        
//----------------------------------------------------------------------------------------------
//-----------------------Modifify from here for onboarding doctor-------------------------------
//----------------------------------------------------------------------------------------------
        doctor.firstName = "Henry"
        doctor.lastName = "Peter"
        doctor.age = 28
        doctor.phoneNumber = "430432040"
        doctor.address = "123 waterhouse 65th ave"
        doctor.profileImg = "https://i.imgur.com/W2BwpVk.png"
        doctor.sex = "Female"
        doctor.verified = true
        doctor.validInsurances = ["Humana","Well Care"]
        doctor.servicesSpecialties = ["FTM", "Urologist"]
//-----------------------------------------------------------------------------------------------
//------------------------End--------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
        return doctor
    }
    
    func updateDataBaseIndex(doctor:doctorTemplate) -> doctorTemplate{
        var index = 0 //Assumer index is 0 then update
        //Read value from database
        group.enter()
        ref.child("doctors").observe(.value) { (DataSnapshot) in
            if self.cycle { //Check if we are returning here for a second time (BUG)
                return
            }
            for field in DataSnapshot.children.allObjects as! [DataSnapshot] {
                if field.key == "allIndex" {
                    index = field.value! as! Int + 1
                }
            }
            doctor.uid = index
            self.writeToAllIndex(index: index)
            self.group.leave()
        }
        return doctor
    }
    
    func writeToAllIndex(index:Int) {
        let values:[String:Any] = ["allIndex":index]
        //Update the Database
        ref.child("doctors").updateChildValues(values)
        cycle = true
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
