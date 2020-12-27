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
    
    var body: some View {
        
        Group {
            if Auth.auth().currentUser == nil {
                LoginView()
            } else {
                TabView{
                    // pass in user to text to change it if need be
//                    InfoView().environmentObject(userToText)
                    InfoView()
                        .tabItem {
                            Image(systemName: "book.fill")
                            Text("Info")
                        }
                    // pass in user to text because this is where the texting happens
//                    LoveView().environmentObject(userToText)
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
                .onAppear() {
                    UITabBar.appearance().barTintColor = .white
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
