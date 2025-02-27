//
//  EditProfileView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 1/14/21.
//

import SwiftUI

struct EditProfileView: View {
//    @Binding var blocks : [[String:String]]
    
    // coming from profileview
    @EnvironmentObject var session : SessionStore
    @Binding var showing : Bool
    var lastConversation: String
    
    // defaults
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

                PageTitleView(title: "Add memory here!")
                RelationshipPickerHeader(show: $showPopup, lastConversation: $lastType, descriptor: "Of type")
                
                if lastType == "text" {

                    HStack {
                        Text("Details").font(.title2).fontWeight(.semibold)
                        Spacer()
                    }.padding(.top)
                    
                    HStack {
                        TextField("Post text here ...", text: $textInput)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200, alignment: .topLeading)
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                        Spacer()
                    }.padding(.top)
                        
   
                } else {
                    
                    HStack {
                        Text("Details").font(.title2).fontWeight(.semibold)
                        Spacer()
                    }.padding(.top)
                    
                    HStack{
                        Spacer()
                        VStack{
                            Spacer()
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100, alignment: .center)
                            
                            Text("Tap to add an image")
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300, alignment: .topLeading)
                    .background(Color(.systemGray6))
                    .foregroundColor(Color(.systemGray3))
                    .cornerRadius(5)
                    .padding(.top)

                    
                    
                    HStack {
                        TextField("Caption ...", text: $textInput)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                    }
                    .padding(.top)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .topLeading)
                      
                }
                HStack {
                    
                    Button {
                        self.session.addBlock(with: lastConversation, update: ["id":UUID().uuidString, "type":lastType, "value":textInput])
                        print(self.session.downloadedRelationships)
                        self.showing.toggle()
                        
                    } label: {
                        Text("Add post").font(.title3)
                    }
                    Spacer()
                }.padding(.top)

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

