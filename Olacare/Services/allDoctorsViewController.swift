//
//  allDoctorsViewController.swift
//  Olacare
//
//  Created by Anthony Bravo on 4/21/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit
import Firebase
import AlamofireImage

class allDoctorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var allDoctorsTableView: UITableView!
    let group = DispatchGroup()
    let group1 = DispatchGroup()
    var doctors:[doctorTemplate] = []
    let ref = Database.database().reference()
    var allIndex = 0
    var done:Bool = false //set to true once we have doctors array filled

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDoctorsFromDatabase()
        tableViewSetUp()

    }
    
    func tableViewSetUp() {
        allDoctorsTableView.dataSource = self;
        allDoctorsTableView.delegate = self;
        self.allDoctorsTableView.rowHeight = 150
    }
    
    func getDoctorsFromDatabase() {
        getCurrentAllIndex()
         group.notify(queue:.main) {
            self.allDoctorsTableView.reloadData()
            var doctorsLocal = Array<doctorTemplate>(repeating: doctorTemplate(), count: self.allIndex+1)
            //Filling Array
            for i in 0...self.allIndex {
                let doctor = doctorTemplate()
        
                //Build back the doctor from data base here at the ith location
                self.group.enter()
                self.ref.child("doctors").child("all").child(String(i)).observe(.value) { (DataSnapshot) in
                    for field in DataSnapshot.children.allObjects as! [DataSnapshot] {
                        //Filling right key to make doctor
                        switch field.key {
                            case "uid":
                                doctor.uid = field.value! as! Int
                            case "firstName":
                                doctor.firstName = field.value! as! String
                            case "lastName":
                                doctor.lastName = field.value! as! String
                            case "age":
                                doctor.age = field.value! as! Int
                            case "phoneNumber":
                                doctor.phoneNumber = field.value! as! String
                            case "address":
                                doctor.address = field.value! as! String
                            case "profileImg":
                                doctor.profileImg = field.value! as! String
                            case "sex":
                                doctor.sex = field.value! as! String
                            case "rating":
                                doctor.rating = field.value as! Double
                            case "verified":
                                doctor.verified = field.value as! Bool
                            case "validInsurances":
                                doctor.validInsurances = field.value as! [String]
                            case "servicesSpecialties":
                                doctor.servicesSpecialties = field.value as! [String]
                            default:
                                print("Key not found!! \(field.key)")
                        }
                    }
                    doctorsLocal[i] = doctor
                    self.group.leave()
                }
                //------------------------------------------
            }
            
            self.group.notify(queue: .main) {
                self.doctors = doctorsLocal
                //Call function that manages the filled Doctor array
                self.manageDoctorArray()
            }

        }
    }
    
//This is the function that get called when the doctor array is created------------------------------------------
    func manageDoctorArray() {
        done = true
        self.allDoctorsTableView.reloadData()
        //printDoctors(doctors: doctors)
    }
//---------------------------------------------------------------------------------------------------------------
    
    func getCurrentAllIndex() {
        //Read value from database
        group.enter()
        ref.child("doctors").observe(.value) { (DataSnapshot) in
            for field in DataSnapshot.children.allObjects as! [DataSnapshot] {
                if field.key == "allIndex" {
                    self.allIndex = field.value! as! Int
                }
            }
            self.group.leave()
        }
    }
    
    func printDoctors(doctors:[doctorTemplate]) {
        for doctor in doctors {
            print("\(doctor.firstName): \(doctor.verified)")
        }
    }

    @IBAction func logoutPressed(_ sender: Any) {
        let loggingVc = storyboard?.instantiateViewController(withIdentifier: "loggingNavigation") as! LoginNavigationController
        present(loggingVc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allIndex+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorCell", for: indexPath) as! doctorTableViewCell
        //Format the cell for specific doctor at location i
        if done {
            let doctor = doctors[indexPath.row]
            //Name
            cell.nameLabel.text = "\(doctor.firstName) \(doctor.lastName)"
            //Profile image
            let doctoUrl = URL(string: doctor.profileImg)!
            cell.profileImageView.af_setImage(withURL: doctoUrl)
            //Specialities: displaying the first 2
            let arr = doctor.servicesSpecialties
            cell.specialtiesLabel.text = "\(arr[0]) \(arr[1])"
            //Verified
            if doctor.verified == false {
                cell.rainbowStampImageView.isHidden = true
            }
            else {
                cell.rainbowStampImageView.isHidden = false
            }
            //Location
            cell.addressLabel.text = doctor.address
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doctorMoreInfo" {
            let moreInfoVC = segue.destination as! moreInfoDoctorViewController
            let cell = sender as! UITableViewCell
            let indexPath = allDoctorsTableView.indexPath(for: cell)
            let index = (indexPath?.row)!
            let doctor = doctors[index]
            moreInfoVC.doctor = doctor
        }
    }
    
    //Removes gray region of selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
