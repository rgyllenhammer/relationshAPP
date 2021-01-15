//
//  EditProfileView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/14/21.
//

import SwiftUI

struct EditProfileView: View {
    @Binding var blocks : [[String:String]]
    @Binding var showing : Bool
    
    @State var showPopup = false
    @State var lastType = "text"
    var types : [String] = ["text", "image"]
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    Button {
                        self.showing.toggle()
                    } label: {
                        HStack{
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                    Spacer()
                }.padding(.bottom)

                PageTitleView(title: "Add post!")
                RelationshipPickerHeader(show: $showPopup, lastConversation: $lastType, descriptor: "Of type")
                
                Button {
                    if lastType == "text" {
                        self.blocks.append(["id":UUID().uuidString, "type":"text", "value":"I hope you know how much I love you and all of that you are my absolute favorite person in the world and I would do anything to love you fore thank you so much for everything my darling"])
                    } else {
                        self.blocks.append(["id":UUID().uuidString, "type":"image", "value":"November 27 - full of love"])
                    }
                    self.showing.toggle()
                    
                } label: {
                    Text("Add post")
                }

                
                Spacer()
            }.padding()
            
            if showPopup {
                PopRelationshipsView(lastPick: $lastType, show: $showPopup, userNames: types)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

