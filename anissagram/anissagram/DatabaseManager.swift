//
//  DatabaseManager.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 12/23/20.
//

import Foundation
import Firebase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func sendNotification(sendTo: String, sendFrom: String, numLove: Int) {
        
        // craft new uuid and add message to database
        let messagesHeader = database.child("messages")
        let newMessage = messagesHeader.child(UUID().uuidString)
        newMessage.setValue(["level": numLove, "sendTo": sendTo, "sendFrom": sendFrom])
    }
    
    public func insertUser(user: User){
        
        // add user to database
        database.child("users").child(user.userName!).setValue([
            "first_name":user.firstName!,
            "last_name":user.lastName!
        ])
        
        // set current device fcm token
        uploadDeviceToken(userName: user.userName!)
    }
    
    public func uploadDeviceToken(userName: String){
        Messaging.messaging().token { token, error in
          if let error = error {
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
    
}
