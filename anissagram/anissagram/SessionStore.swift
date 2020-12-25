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
    func signUp(email: String, password: String) {
        print("sign up new user")
        Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, err in
            
            // pass this data in from form
            let userName = "ranchgod"
            let firstName = "reese"
            let lastName = "gyllenhammer"
            
            if err != nil {
                print("reese we are in the doghouse now")
            } else {
                self.session = User(
                    uid: authResult!.user.uid,
                    email: authResult!.user.email,
                    displayName: authResult!.user.displayName,
                    userName: userName,
                    firstName: firstName,
                    lastName: lastName
                )
                
                // insert user to firebase
                DatabaseManager.shared.insertUser(user: self.session!)
            }
            
            
        })

    }

    // TODO: Sign in an existing user with Firebase AUthentication
    func signIn(email: String, password: String) {
        print("sign in new user")
        Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, err in
            
            // grab this data from firebase
            let userName = "ranchgod"
            let firstName = "reese"
            let lastName = "gyllenhammer"
            
            if err != nil {
                print("reese we are in the doghouse now")
            } else {
                self.session = User(
                    uid: authResult!.user.uid,
                    email: authResult!.user.email,
                    displayName: authResult!.user.displayName,
                    userName: userName,
                    firstName: firstName,
                    lastName: lastName
                )
                
                // update current fcm token in case logged in on new device
                DatabaseManager.shared.uploadDeviceToken(userName: self.session!.userName!)
            }
        })
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
    
    /// Stop listening to our authentication change handler
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
}
