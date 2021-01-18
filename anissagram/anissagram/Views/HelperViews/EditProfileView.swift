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
//                            .frame(width: UIScreen.main.bounds.width - 30, height: 200, alignment: .top)
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                        Spacer()
                    }
                        
   
                } else {
                    
                    HStack {
                        Text("Details").font(.title2).fontWeight(.semibold)
                        Spacer()
                    }.padding(.top)
                    
                    Image(systemName: "camera")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.aRed)
                        
                    HStack {
                        TextField("Caption ...", text: $textInput)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .topLeading)
//                            .frame(width: UIScreen.main.bounds.width - 30, height: 200, alignment: .top)
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                        Spacer()
                    }
                      
                }
                HStack {
                    
                    Button {
                        if lastType == "text" {
                            self.blocks.append(["id":UUID().uuidString, "type":"text", "value":textInput])
                        } else {
                            self.blocks.append(["id":UUID().uuidString, "type":"image", "value":textInput])
                        }
                        self.showing.toggle()
                        
                    } label: {
                        Text("Add post").font(.title3)
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

