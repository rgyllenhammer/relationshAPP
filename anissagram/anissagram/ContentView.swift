//
//  ContentView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/24/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userToText : User
    
    var body: some View {
            TabView{
                // pass in user to text to change it if need be
                InfoView().environmentObject(userToText)
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("Info")
                    }
                // pass in user to text because this is where the texting happens
                LoveView().environmentObject(userToText)
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                        Text("Notify")
                    }
                FoodView()
                    .tabItem {
                        Image(systemName: "car")
                        Text("Food")
                    }
                ProfileView()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(User(sendTo: "reese", sendFrom: "anissa"))
    }
}
