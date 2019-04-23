//
//  doctor.swift
//  Olacare
//
//  Created by Anthony Bravo on 4/22/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import Foundation

class doctorTemplate {
    var uid:Int = 0 //Index on all field
    var allIndex:Int = 0 //the last index on all field
    var firstName:String = ""
    var lastName:String = ""
    var age:Int = 0
    var phoneNumber:String = ""
    var address:String = ""
    var profileImg:String = ""
    var sex:String = ""
    var rating:Double = 0.0
    var verified:Bool = false
    var validInsurances:[String:Any] = [:]
    var servicesSpecialties:[String:Any] = [:]
}
