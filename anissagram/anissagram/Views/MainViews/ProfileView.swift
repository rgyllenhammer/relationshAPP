//
//  ProfileView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/24/20.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionStore
    @State var show = false
    @State var lastConversation = String.loading
    
    func createUserNames(relationships: NSDictionary?) -> [String]{
        return relationships?.allKeys as? [String] ?? Array(repeating: "nil", count: 25)
    }
    
    var body: some View {
        
        ZStack {
            ScrollView {
                LazyVStack {
                    HStack {
                        PageTitleView(title: "Photos for you!")
                        Spacer()
                        NavigationLink(destination:
                                        VStack {
                                            Text("HELLO")
                                            Spacer()
                                        }
                                       , label: {
                                            Text("Edit")
                                        })
                    }
                    
                    RelationshipPickerHeader(show: $show, lastConversation: $lastConversation, descriptor: "With")
                    
                    ProfileTextView(textToDisplay: "I hope you know how much I love you and all of that you are my absolute favorite person in the world and I would do anything to love you fore thank you so much for everything my darling")
                    
                    ProfileImageView(captionText: "December 7 - Our first kiss")
                    
                    ProfileTextView(textToDisplay: "Now I want you to know how awesome it is that we have had the opprotunit to be with the same area that we were previoyusly being around with our frien and all fo that")

                    
                }.padding()
            }
            
            // pops up the reader to display users to choose
            if self.show {
                PopRelationshipsView(lastConversation: $lastConversation, show: $show).environmentObject(session)
            }
            
        }.onAppear(perform: {
            if let user = self.session.session {
                self.lastConversation = user.userName
            }
        })
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
