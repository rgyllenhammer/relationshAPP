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
    
    @State var test = false
    
    @State var editing = false
    
    func fetchDataFromLastConvo() {
        
        session.downloadedRelationships[lastConversation] = [["type":"text", "value":"Hello! Welcome to a relationship between \(session.session!.userName) and \(lastConversation)! Here is a place you can post memories with this person, and only you two can see it! To add a memory, click the plus button in the top right and choose either an image or block of text to add. To delete a memory (like this one) hold down and press delete! This is a space for you all now!"]]
    }
    
    var body: some View {
        
        ZStack {
            ScrollView {
                LazyVStack {
                    HStack {
                        PageTitleView(title: "Memories for you!")
                        Spacer()
                        NavigationLink(destination: EditProfileView(showing: $editing, lastConversation: lastConversation).environmentObject(session),
                                       isActive: $editing,
                                       label: {
                                        Image(systemName: "plus")
                                            .foregroundColor(.aRed)
                                            .font(.title2)
                                       })
                    }
                    
                    RelationshipPickerHeader(show: $show, lastConversation: $lastConversation, descriptor: "With")
                    
                    if (session.downloadedRelationships[lastConversation] != nil){
                        ForEach(session.downloadedRelationships[lastConversation]!, id: \.self["id"]) { block in
                            if block["type"] == "text" {
                                ProfileTextView(textToDisplay: block["value"]!)
                            } else {
                                ProfileImageView(captionText: block["value"]!)
                            }
                        }
                    } else {
                        
                        NothingToDisplayView().padding(.top, 50).onAppear(perform: {
                            fetchDataFromLastConvo()
                        })
                    }
                    
                    
                }.padding()
            }
            
            // pops up the reader to display users to choose
            if self.show {
                PopRelationshipsView(lastPick: $lastConversation, show: $show, userNames: session.createUserNames())
            }
            
        }.onAppear(perform: {
            if let user = self.session.session {
                
                // initial load has not been updated
                if self.lastConversation == String.loading {
                    self.lastConversation = user.userName
                }
                                
            }
        })
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
