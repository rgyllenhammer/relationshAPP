//
//  LoveView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/24/20.
//

import SwiftUI
import Firebase
//import MessageUI

struct LoveView: View {
    
    @EnvironmentObject var userToText : User
    
//    private let messageComposeDelegate = MessageComposerDelegate()
    @State var showingAlert = false
    var ref = Database.database().reference()
    @State var numLove = 0
    @State var fullSize = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                HStack{
                    HStack{
                        Text("Need Level:")
                        Text("\(numLove)").foregroundColor(.orange).fontWeight(.bold)
                    }.font(.title)
                    Spacer()
                    Button(action: {
                        let test = ref.child("messages")
                        let newTest = test.child(UUID().uuidString)
                        newTest.setValue(["level": numLove, "sendTo": userToText.sendTo!, "sendFrom": userToText.sendFrom!])
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        showingAlert = true
                        numLove = 0
                        
                    }, label: {
                        HStack{
                            Text("Send")
                            Image(systemName: "chevron.right")
                        }
                        .font(.title)
                        .foregroundColor(.red)
                    }).alert(isPresented: $showingAlert) {
                        Alert(title: Text("Request Sent!"), message: Text("Succesfully sent \(userToText.sendTo!) an attention request!"), dismissButton: .default(Text("Got it!")))
                    }
                }.padding()
                
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

            }.padding(.bottom, 50)
        }
        
    }
}

// LEGACY FROM WHEN USING TEXT INSTEAD OF NOTIFICATION

//extension LoveView {
//
//    private class MessageComposerDelegate: NSObject, MFMessageComposeViewControllerDelegate {
//        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
//            // Customize here
//            controller.dismiss(animated: true)
//        }
//    }
//
//    private func presentMessageCompose(numLove: Int, user: User) {
//        guard MFMessageComposeViewController.canSendText() else {
//            return
//        }
//        let vc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
//        let composeVC = MFMessageComposeViewController()
//        composeVC.messageComposeDelegate = messageComposeDelegate
//        composeVC.recipients = [user.phoneNumbr!]
//        composeVC.body = "Hiiii. I need a attention and love level of \(numLove) right now\n\nThank you :)"
//
//        vc?.present(composeVC, animated: true)
//    }
//}

struct LoveView_Previews: PreviewProvider {
    static var previews: some View {
        LoveView()
    }
}
