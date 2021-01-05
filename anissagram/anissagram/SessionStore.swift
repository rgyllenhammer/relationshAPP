//
//  SessionStore.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 12/23/20.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import Combine

class SessionStore: ObservableObject {
    
    @Published var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    

    func signUp(email: String, password: String, userName: String, firstName: String, lastName: String) {
        print("sign up new user")
        Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, err in
                
            if err != nil {
                print("Error signing up. Email already in use")
            } else {
                self.session = User(
                    uid: authResult!.user.uid,
                    email: authResult!.user.email,
                    displayName: authResult!.user.displayName,
                    userName: userName,
                    firstName: firstName,
                    lastName: lastName,
                    relationships: [userName: UUID().uuidString],
                    lastConversation: userName
                )
                
                // insert user to firebase
                DatabaseManager.shared.insertUser(user: self.session!)
            }
        })
    }

    func signIn(email: String, password: String, userName: String) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, err in
            
            if (err != nil) {
                print("Unable to retrieve user from database, please check that the name is correct")
                return
            }
            
            DatabaseManager.shared.retrieveUserByUsername(userName: userName) { (userObject, error) in
                
                // grab this data from firebase
                
                let firstName = userObject?["first_name"] as! String
                let lastName = userObject?["last_name"] as! String
                let relationships = userObject?["relationships"] as! NSDictionary
                
                print("GOT USER WITH FIRSTNAME \(firstName) AND LASTNAME \(lastName)")
                print("sign in new user")
                
                if (error) {
                    print("Unable to login, check username and password")
                } else {
                    
                    print("error is not nil, the problem is writing before we are authorized")
                    
                    self.session = User(
                        uid: authResult!.user.uid,
                        email: authResult!.user.email,
                        displayName: authResult!.user.displayName,
                        userName: userName,
                        firstName: firstName,
                        lastName: lastName,
                        relationships: relationships,
                        lastConversation: userName
                    )
                    
                    // update current fcm token in case logged in on new device
                    DatabaseManager.shared.uploadDeviceToken(userName: self.session!.userName!)
                }
            }
        })
    }
    
    func setupUser(email: String, uid: String, displayName: String, userName: String) {
        DatabaseManager.shared.retrieveUserByUsername(userName: userName) { (userObject, error) in
            if (error) {
                print("Unable to retrieve user from database, please check that the name is correct")
                return
            }
            
            let firstName = userObject?["first_name"] as! String
            let lastName = userObject?["last_name"] as! String
            let relationships = userObject?["relationships"] as! NSDictionary
            
            self.session = User(
                uid: uid,
                email: email,
                displayName: displayName,
                userName: userName,
                firstName: firstName,
                lastName: lastName,
                relationships: relationships,
                lastConversation: userName
            )
            
        }
    }

    func signOut() {
        print("signing out current user")
        do {
            try Auth.auth().signOut()
            self.session = nil
            print("signout successfull")
        } catch {
            print("Error during signout")
        }
    }
    
    func updateSession(){
        print("session is changing")
        self.didChange.send(self)
    }
    
    func isInRelationship(with name: String) -> Bool {
        return self.session?.relationships[name] != nil
    }
    
    func addRelationShip(with name: String) {
        let newUUID = UUID().uuidString
        if let user = self.session {
            DatabaseManager.shared.addRelationship(userName: user.userName ?? .username, relationshipUser: name, relationshipUUID: newUUID)
            
            let muteable : NSMutableDictionary = NSMutableDictionary(dictionary: user.relationships)
            muteable[name] = newUUID
            session?.relationships = muteable
            
            self.updateSession()
        }
        
    }
    
}
