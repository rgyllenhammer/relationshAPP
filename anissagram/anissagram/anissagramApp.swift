//
//  anissagramApp.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/24/20.
//

import SwiftUI
import Firebase

@main
struct anissagramApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SessionStore())
        }
    }
}
