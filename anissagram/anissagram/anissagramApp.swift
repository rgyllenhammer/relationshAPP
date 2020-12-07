//
//  anissagramApp.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/24/20.
//

import SwiftUI

@main
struct anissagramApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            // assuming anissa will usually be using the app so I default to person to call as mine
            ContentView().environmentObject(User(sendTo: "reese", sendFrom: "anissa"))
        }
    }
}
