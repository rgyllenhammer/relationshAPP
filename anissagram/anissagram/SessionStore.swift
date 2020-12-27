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
    var handle: AuthStateDidChangeListenerHandle?

    // TODO: Sign up a new user with Firebase Authentication
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
                    relationships: [[userName: UUID().uuidString]],
                    lastConversation: userName
                )
                
                // insert user to firebase
                DatabaseManager.shared.insertUser(user: self.session!)
            }
        })
    }

    // TODO: Sign in an existing user with Firebase AUthentication
    func signIn(email: String, password: String, userName: String) {
        
        DatabaseManager.shared.retrieveUserByUsername(userName: userName) { (userObject, error) in
            
            if (error) {
                print("Unable to retrieve user from database, please check that the name is correct")
                return
            }
            
            let firstName = userObject?["first_name"] as! String
            let lastName = userObject?["last_name"] as! String
            let relationships = userObject?["relationships"] as! [NSDictionary]
            
            print("GOT USER WITH FIRSTNAME \(firstName) AND LASTNAME \(lastName)")
            
            print("sign in new user")
            Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, err in
                
                // grab this data from firebase
                if err != nil {
                    print("Unable to login, check username and password")
                } else {
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
            })
        }
    }

    // TODO: Sign out the current user
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
    
}
