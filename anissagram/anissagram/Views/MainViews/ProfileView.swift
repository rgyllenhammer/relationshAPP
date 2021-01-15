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
    
    @State var editing = false
    @State var blocks : [[String:String]] = [
        ["id": UUID().uuidString, "type": "text", "value": "I hope you know how much I love you and all of that you are my absolute favorite person in the world and I would do anything to love you fore thank you so much for everything my darling"],
        ["id" : UUID().uuidString, "type": "image", "value": "December 7th, when we fell in lov"],
    ]
    
    var body: some View {
        
        ZStack {
            ScrollView {
                LazyVStack {
                    HStack {
                        PageTitleView(title: "Photos for you!")
                        Spacer()
                        NavigationLink(destination: EditProfileView(blocks: $blocks, showing: $editing),
                                       isActive: $editing,
                                       label: {
                                            Text("Edit")
                                       })
                    }
                    
                    RelationshipPickerHeader(show: $show, lastConversation: $lastConversation, descriptor: "With")
                    
                    ForEach(blocks, id: \.self["id"]) { block in
                        if block["type"] == "text" {
                            ProfileTextView(textToDisplay: block["value"]!)
                        } else {
                            ProfileImageView(captionText: block["value"]!)
                        }
                    }
                    
//                    ProfileTextView(textToDisplay: "I hope you know how much I love you and all of that you are my absolute favorite person in the world and I would do anything to love you fore thank you so much for everything my darling")
//
//                    ProfileImageView(captionText: "December 7 - Our first kiss")
//
//                    ProfileTextView(textToDisplay: "Now I want you to know how awesome it is that we have had the opprotunit to be with the same area that we were previoyusly being around with our frien and all fo that")

                    
                }.padding()
            }
            
            // pops up the reader to display users to choose
            if self.show {
                PopRelationshipsView(lastPick: $lastConversation, show: $show, userNames: session.createUserNames())
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
