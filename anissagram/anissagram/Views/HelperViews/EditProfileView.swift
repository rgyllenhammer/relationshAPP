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
    
    @State var textInput = ""
    
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
                
                if lastType == "text" {

                    HStack {
                        Text("Post text").font(.title2).fontWeight(.semibold)
                        Spacer()
                    }.padding(.top)
                    HStack {
                        TextField("Type here ...", text: $textInput)
                            .padding()
                            .frame(width: 300, height: 200, alignment: .top)
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                        Spacer()
                    }
                        
   
                } else {
                    
                    
                    
                    
                    
                }
                HStack {
                    
                    Button {
                        if lastType == "text" {
                            self.blocks.append(["id":UUID().uuidString, "type":"text", "value":textInput])
                        } else {
                            self.blocks.append(["id":UUID().uuidString, "type":"image", "value":"November 27 - full of love"])
                        }
                        self.showing.toggle()
                        
                    } label: {
                        Text("Add post")
                    }
                    Spacer()
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

