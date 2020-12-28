//
//  ContentView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/24/20.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
//    @EnvironmentObject var userToText : User
    @EnvironmentObject var session: SessionStore
    var cachedDefaults = UserDefaults.standard
    @State var currentUserName = ""
    
    var body: some View {
        
        Group {
            if Auth.auth().currentUser == nil {
                LoginView()
            } else {
                TabView{
                    // pass in user to text to change it if need be
                    InfoView()
                        .tabItem {
                            Image(systemName: "book.fill")
                            Text("Info")
                        }
                    // pass in user to text because this is where the texting happens
                    LoveView().environmentObject(session)
                        .tabItem {
                            Image(systemName: "suit.heart.fill")
                            Text("Notify")
                        }
                    FoodView()
                        .tabItem {
                            Image(systemName: "car")
                            Text("Food")
                        }
                    ProfileView().environmentObject(session)
                        .tabItem {
                            Image(systemName: "figure.wave")
                            Text("Mems")
                        }
                }
                .accentColor(.red)
                .onAppear(perform: {
                    UITabBar.appearance().barTintColor = .white
                    if (session.session == nil) {
                        print("session is nil, loading cached username to fetch from firebase")
                        self.load()
                    } else {
                        print("session is not nil, cacheing username")
                        self.save()
                    }
                })
//                {
//                    UITabBar.appearance().barTintColor = .white
//                    if (session.session == nil) {
//                        print("session is nil, loading cached username to fetch from firebase")
//                        self.load()
//                    } else {
//                        print("session is not nil, cacheing username")
//                        self.save()
//                    }
//
//                }
            }
        }
    }
    
    func load() {
        let cachedUsername = cachedDefaults.string(forKey: "username")
        currentUserName = cachedUsername ?? "nil"
    }
    
    func save() {
        currentUserName = (self.session.session?.userName!)!
        cachedDefaults.set(session.session?.userName!, forKey: "username")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
