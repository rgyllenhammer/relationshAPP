//
//  LoveView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/24/20.
//

import SwiftUI
import Firebase

struct LoveView: View {
    
    @EnvironmentObject var session: SessionStore
    @State var showingAlert = false
    @State var numLove = 0
    @State var fullSize = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                VStack{
                    HStack{
                        Text("Request attention!").font(.largeTitle).fontWeight(.bold)
                        Spacer()
                    }
                    HStack{
                        Text("From")
                        Text("@\((session.session?.lastConversation) ?? "nil" )").foregroundColor(.aYellow)
                        Spacer()
                    }.font(.title3)
                }
                .padding(.bottom)
                HStack{
                    HStack{
                        Text("Level:")
                        Text("\(numLove)").foregroundColor(.orange).fontWeight(.bold)
                    }.font(.title)
                    Spacer()
                    Button(action: {
                        // Firebase communication
                        DatabaseManager.shared.sendNotification(sendTo: "\(session)", sendFrom: "anissa", numLove: numLove)

                        // Haptic Feedback
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()

                        // Re-set values
                        showingAlert = true
                        numLove = 0

                    }, label: {
                        HStack{
                            Text("Send")
                            Image(systemName: "chevron.right")
                        }
                        .font(.title)
                        .foregroundColor(.aRed)
                    }).alert(isPresented: $showingAlert) {
                        
                        Alert(title: Text("Request Sent!"), message: Text("Succesfully sent \((session.session?.lastConversation) ?? "nil") an attention request!"), dismissButton: .default(Text("Got it!")))
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
        
    }
}

struct LoveView_Previews: PreviewProvider {
    static var previews: some View {
        LoveView()
    }
}
