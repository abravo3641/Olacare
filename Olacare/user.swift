//
//  user.swift
//  Olacare
//
//  Created by Anthony Bravo on 3/22/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import Foundation

class user {
    let email:String!
    let password:String!
    let firstName:String!
    let lastName:String!
    let birthMonth:Int!
    let birthDay:Int!
    let birthYear:Int!
    
    init(email:String, password:String, firstName:String, lastName:String, birthMonth:Int, birthDay:Int, birthYear:Int) {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.birthMonth = birthMonth
        self.birthDay = birthDay
        self.birthYear  = birthYear
    }
}
