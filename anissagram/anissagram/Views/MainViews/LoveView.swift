//
//  LoveView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/24/20.
//

import SwiftUI
import Firebase
import Foundation

struct LoveView: View {
    
    @EnvironmentObject var session: SessionStore
    @State var showingAlert = false
    @State var numLove = 0
    @State var fullSize = true
    @State var show = false
    @State var lastConversation = String.loading
    
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    VStack{
                        PageTitleView(title: "Request attention!")
                        RelationshipPickerHeader(show: $show, lastConversation: $lastConversation, descriptor: "From")
                        
                        HStack{
                            HStack{
                                Text("Level:")
                                Text("\(numLove)").foregroundColor(.orange).fontWeight(.bold)
                            }.font(.title)
                            Spacer()
                            Button(action: {
                                
                                // haptic feedback
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()

                                // Firebase communication iff user is set
                                if let user = session.session {
                                    DatabaseManager.shared.sendNotification(sendTo: lastConversation, sendFrom: user.userName, numLove: numLove)

                                    showingAlert = true
                                    numLove = 0
                                } else {
                                    // TODO show error if user not yet loaded
                                }

                            }, label: {
                                HStack{
                                    Text("Send")
                                    Image(systemName: "chevron.right")
                                }
                                .font(.title)
                                .foregroundColor(.aRed)
                            }).alert(isPresented: $showingAlert) {
                                
                                Alert(title: Text("Request Sent!"), message: Text("Succesfully sent \("anissa") an attention request!"), dismissButton: .default(Text("Got it!")))
                            }
                        }

                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                                numLove = numLove + 1
                            }, label: {
                                VStack{
                                    Image(systemName: "heart.fill").font(.system(size: geometry.size.width/8))
                                }.frame(width: geometry.size.width / 2, height: geometry.size.width / 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.red)
                                .cornerRadius(geometry.size.width/4)
                                .foregroundColor(.white)
                                .shadow(color: .red, radius: 5)
                            }).animation(.easeInOut)
                            Spacer()
                        }

                    }.padding()
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
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
    
    func createUserNames(relationships: NSDictionary?) -> [String]{
        return relationships?.allKeys as? [String] ?? Array(repeating: "nil", count: 25)
    }
    
}

struct LoveView_Previews: PreviewProvider {

    static var previews: some View {
        LoveView()
    }
}
