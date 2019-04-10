import UIKit
import Firebase

class signUpViewControllerPart4: UIViewController {

    var user:userTemplate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func printUser() {
        print("\nUser created: \n   email = \(user.email) \n   password: \(user.password) \n   name: \(user.firstName) \(user.lastName) \n   birthday: \(user.birthMonth)/\(user.birthDay)/\(user.birthYear) \n   Age: \(user.age)")
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        printUser()
        createUserInDatabase(user: user)
    }
    
    func createUserInDatabase(user:userTemplate) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
            if error != nil {
                print("Error Creating User: ", error?.localizedDescription as Any)
            }
            else {
                //Create user values on Database
                let uid = result?.user.uid
                let values = ["email":user.email, "password":user.password, "firstName":user.firstName, "lastName":user.lastName, "birthMonth":user.birthMonth, "birthDay":user.birthDay, "birthYear":user.birthYear, "age":user.age] as [String : Any]
                Database.database().reference().child("users").child(uid!).updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print("Error Creating User", error?.localizedDescription as Any)
                    }
                    else {
                        print("Succesfully created user on the Database!")
                    }
                })
            }
        }
    }
}
