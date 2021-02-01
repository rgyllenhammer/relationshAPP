//
//  User.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/26/20.
//

import Foundation
import Combine

class User : ObservableObject {
    
    var uid: String
    var email: String
    var displayName: String?
    var userName: String
    var firstName: String
    var lastName: String
    var relationships: NSMutableDictionary
    var requests : NSMutableDictionary
    var pending : NSMutableDictionary
    var fullName: String
//    var downloadedRelationships : Dictionary<String, Array<Dictionary<String, String>>> = [:]
    
    init(uid: String, email: String, displayName: String?,
         userName: String, firstName: String, lastName: String,
         relationships: NSMutableDictionary, requests: NSMutableDictionary, pending: NSMutableDictionary) {
        
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.relationships = relationships
        self.fullName = "\(firstName) \(lastName)"
        self.requests = requests
        self.pending = pending
    }
}
