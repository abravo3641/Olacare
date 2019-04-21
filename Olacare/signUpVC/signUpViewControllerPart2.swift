
import UIKit
import M13Checkbox
import Firebase



class signUpViewControllerPart2: UIViewController {
    
    
    @IBOutlet weak var firstPronoun: M13Checkbox!
    @IBOutlet weak var secondPronoun: M13Checkbox!
    @IBOutlet weak var thirdPronoun: M13Checkbox!
    @IBOutlet weak var fourthPronoun: M13Checkbox!
    @IBOutlet weak var fifthPronoun: M13Checkbox!
    @IBOutlet weak var sixthPronoun: M13Checkbox!
    @IBOutlet weak var seventhPronoun: M13Checkbox!
    
    var user:userTemplate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "thirdSignUpWindow" {
            savePronouns()
            let thirdSingUpVC = segue.destination as! signUpViewControllerPart3
            thirdSingUpVC.user = user
        }
    }
    
    //Save Pronouns to user
    func savePronouns() {
        let keys:[String] = ["they-them-their","he-him-his","she-her-hers","ve-ver-vis","xe-xem-xyr","per-per-pers","zie-zim-zir"]
        let value:[Bool] = checkStatus()
        let pronounValues:[String:Any] = [keys[0]:value[0],keys[1]:value[1],keys[2]:value[2],keys[3]:value[3],keys[4]:value[4],keys[5]:value[5],keys[6]:value[6]]
        user.pronounValues = pronounValues
    }
    
    func checkStatus()->[Bool] {
        var result:[Bool] = [false,false,false,false,false,false,false]
        //Checking if pronouns got checked
        if firstPronoun.checkState.rawValue == "Checked" {
            result[0] = true
        }
        if secondPronoun.checkState.rawValue == "Checked" {
            result[1] = true
        }
        if thirdPronoun.checkState.rawValue == "Checked" {
            result[2] = true
        }
        if fourthPronoun.checkState.rawValue == "Checked" {
            result[3] = true
        }
        if fifthPronoun.checkState.rawValue == "Checked" {
            result[4] = true
        }
        if sixthPronoun.checkState.rawValue == "Checked" {
            result[5] = true
        }
        if seventhPronoun.checkState.rawValue == "Checked" {
            result[6] = true
        }

        return result
    }
    
}

