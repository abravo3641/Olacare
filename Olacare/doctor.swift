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
    var firstName:String = ""
    var lastName:String = ""
    var bio:String = ""
    var phoneNumber:String = ""
    var address:String = ""
    var profileImg:String = ""
    var rating:Double = 0.0
    var certification:String = ""
    var verified:Bool = false
    var validInsurances:[String] = []
    var servicesSpecialties:[String] = []
}
