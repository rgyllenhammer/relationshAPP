//
//  User.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/26/20.
//

import Foundation

class User {
    var uid: String
    var email: String?
    var displayName: String?
    var userName: String?
    var firstName: String?
    var lastName: String?
    
    init(uid: String, email: String?, displayName: String?, userName: String?, firstName: String?, lastName: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
    }
}
