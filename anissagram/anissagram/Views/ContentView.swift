//
//  ContentView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/24/20.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    
    // state and environment variables
    @EnvironmentObject var session: SessionStore
    @State var currentUserName = ""
    
    // local variables
    var cachedDefaults = UserDefaults.standard
    
    var body: some View {
        
        Group {
            if Auth.auth().currentUser == nil {
                LoginView()
            } else {
                TabView {
                    ExploreView().environmentObject(session)
//                    TestView()
                        .tabItem {
                            Image(systemName: "book.fill")
                            Text("Info")
                        }
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
                        self.load(user: Auth.auth().currentUser)
                    } else {
                        print("session is not nil, cacheing username")
                        self.save()
                    }
                })
            }
        }
    }
    
    func load(user: FirebaseAuth.User?) {
        let cachedUsername = cachedDefaults.string(forKey: "username") ?? "nil"
        let email = (user?.email!)!
        let uid  = user?.uid
        let displayName = user?.displayName ?? "nil"
        
        session.setupUser(email: email, uid: uid!, displayName: displayName, userName: cachedUsername)
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
