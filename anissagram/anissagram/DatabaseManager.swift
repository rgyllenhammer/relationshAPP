//
//  DatabaseManager.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 12/23/20.
//

import Foundation
import Firebase

final class DatabaseManager {
    // shared public accessor
    static let shared = DatabaseManager()
    
    // reference to database
    private let database = Database.database().reference()
    
    // functions
    public func sendNotification(sendTo: String, sendFrom: String, numLove: Int) {
        
        // craft new uuid and add message to database
        let messagesHeader = database.child("messages")
        let newMessage = messagesHeader.child(UUID().uuidString)
        newMessage.setValue(["level": numLove, "sendTo": sendTo, "sendFrom": sendFrom])
    }
    
    public func insertUser(user: User){
        
        // setting inital data for user
        let userBody : NSDictionary = [
            "first_name": user.firstName,
            "last_name": user.lastName,
            "relationships": user.relationships
        ]
        
        // setting inital relationship as uuid of relationship pointing to self username
        let relationshipBody : NSDictionary = [
                "users": [user.userName, user.userName],
                "data": "NONE"
        ]
        
        // setting inital data for user and first relationships
        let updates = [
            "users/\(user.userName)/" : userBody,
            "relationships/\(user.relationships[user.userName])" : relationshipBody
//            "relationships/\(user.relationships![user.userName!]!)" : relationshipBody
        ] as [String : Any]
        
        // add user to database
        database.updateChildValues(updates)
        
        // set current device fcm token
        uploadDeviceToken(userName: user.userName)
    }
    
    public func uploadDeviceToken(userName: String){
        print("attempting to yeeeee")
        Messaging.messaging().token { token, error in
          if let error = error {
            
            print("unauth")
            print("Error fetching FCM registration token: \(error)")
            
            
          } else if let token = token {
            print("FCM registration token: \(token)")
            self.database.child("users").child(userName).child("deviceID").setValue(token)
          }
        }
    }
    
    public func retrieveUserByUsername(userName: String, completion: @escaping ((NSDictionary?, Bool) -> Void)) {
        database.child("users").child(userName).observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            if (value != nil){
                completion(value, false)
            } else {
                completion(nil, true)
            }
            
        })
    }
    
    public func addRelationship(userName: String, relationshipUser: String, relationshipUUID: String) {
        let updates = [
            "users/\(userName)/relationships/\(relationshipUser)": relationshipUUID,
            "users/\(relationshipUser)/relationships/\(userName)": relationshipUUID,
            "relationships/\(relationshipUUID)" : [
                "users": [userName, relationshipUser],
                "data": "NONE"
            ]
        ] as [String : Any]
        
        database.updateChildValues(updates)
    }
    
    public func downloadUsers(completion: @escaping (([String]) -> Void)){
        database.child("users").observeSingleEvent(of: .value) { snapshot in
            var users : [String] = []
            for user in snapshot.children {
                let user_snap = user as! DataSnapshot
                users.append(user_snap.key)
            }
            completion(users)
        }
    }
    
}
