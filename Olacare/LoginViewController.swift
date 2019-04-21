

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user:userTemplate!
    let semaphore = DispatchSemaphore(value: 0)
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
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
    
    
}
