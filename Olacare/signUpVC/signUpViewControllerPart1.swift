
import UIKit

class signUpViewControllerPart1: UIViewController {

    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var confirmedEmailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    
    var user:userTemplate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}
