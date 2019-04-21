//
//  user.swift
//  Olacare
//
//  Created by Anthony Bravo on 3/22/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import Foundation

class userTemplate {
    var uid:String = ""
    var email:String = ""
    var password:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var birthMonth:Int = 0
    var birthDay:Int = 0
    var birthYear:Int = 0
    var age:Int = 0
    var pronounValues:[String:Any] = [:]
    var genderValues:[String:Any] = [:]
    var sexualOrientationValues:[String:Any] = [:]
    var sexualActivitiesValues:[String:Any] = [:]
    var sex:String = ""
    var transitioned:String = ""
    var insuranceName:String = ""
    var insuranceID:String = ""
    
    
    func printUser() {
        print("Email: \(email) \nPassword: \(password) \nFirst Name: \(firstName) \nLast Name: \(lastName) \nBirth Month: \(birthMonth) \nBirth Day: \(birthDay) \nBirth Year: \(birthYear) \nAge: \(age) \nSex: \(sex)\ntransitioned: \(transitioned)\nInsurance Name: \(insuranceName)\nInsuranceId: \(insuranceID)\n" )
    }
    func printPronouns() {
        dump(pronounValues)
    }
    func printGenders() {
        dump(genderValues)
    }
    func printSexualOrientation() {
        dump(sexualOrientationValues)
    }
    func printSexualActivities() {
        dump(sexualActivitiesValues)
    }
    
}
