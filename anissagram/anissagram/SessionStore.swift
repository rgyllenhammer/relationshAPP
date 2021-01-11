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
                    email: authResult!.user.email!,
                    displayName: authResult!.user.displayName,
                    userName: userName,
                    firstName: firstName,
                    lastName: lastName,
                    relationships: [userName: UUID().uuidString],
                    requests: [:],
                    pending: [:]
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
                
                // values always are populated
                let firstName = userObject?["first_name"] as! String
                let lastName = userObject?["last_name"] as! String
                let relationships = userObject?["relationships"] as! NSMutableDictionary

                // values may be nil
                let requests : NSMutableDictionary = userObject?["requests"] as? NSMutableDictionary ?? [:]
                let pending : NSMutableDictionary = userObject?["pending"] as? NSMutableDictionary ?? [:]
                
                print("GOT USER WITH FIRSTNAME \(firstName) AND LASTNAME \(lastName)")
                print("sign in new user")
                
                if (error) {
                    print("Unable to login, check username and password")
                } else {
                    
                    print("error is not nil, the problem is writing before we are authorized")
                    
                    self.session = User(
                        uid: authResult!.user.uid,
                        email: authResult!.user.email!,
                        displayName: authResult!.user.displayName,
                        userName: userName,
                        firstName: firstName,
                        lastName: lastName,
                        relationships: relationships,
                        requests: requests,
                        pending: pending
                    )
                    
                    // update current fcm token in case logged in on new device
                    DatabaseManager.shared.uploadDeviceToken(userName: self.session!.userName)
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
            let relationships = userObject?["relationships"] as! NSMutableDictionary
            
            // values may be nil
            let requests : NSMutableDictionary = userObject?["requests"] as? NSMutableDictionary ?? [:]
            let pending : NSMutableDictionary = userObject?["pending"] as? NSMutableDictionary ?? [:]
            
            self.session = User(
                uid: uid,
                email: email,
                displayName: displayName,
                userName: userName,
                firstName: firstName,
                lastName: lastName,
                relationships: relationships,
                requests: requests,
                pending: pending
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
    
    func isPendingRelationship(with name: String) -> Bool {
        return self.session?.pending[name] != nil
    }
    
    func isRequestedRelationship(from name: String) -> Bool {
        return self.session?.requests[name] != nil
    }
    
    func addRelationShip(with name: String) {
        let newUUID = UUID().uuidString
        if let user = self.session {
            DatabaseManager.shared.addRelationship(userName: user.userName, relationshipUser: name, relationshipUUID: newUUID)
            
            user.relationships[name] = newUUID
            
            self.updateSession()
        }
    }
    
    func addRequest(with name: String) {
        let newUUID = UUID().uuidString
        if let user = self.session {
            // CALL TO DBMS FOR ADDING PENDING TO OURS AND REQUEST TO ANOTHER
            DatabaseManager.shared.addRequest(userName: user.userName, relationshipUser: name, relationshipUUID: newUUID)
            
            user.pending[name] = newUUID
            
            self.updateSession()
            
        }
    }
    
    
}
