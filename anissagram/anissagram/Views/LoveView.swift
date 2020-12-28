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
    @State var show = false
    
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    VStack{
                        VStack{
                            HStack{
                                Text("Request attention!").font(.largeTitle).fontWeight(.bold)
                                Spacer()
                            }
                            HStack{
                                Text("From")
        //                        Text("@\((session.session?.lastConversation) ?? "nil" )").foregroundColor(.aYellow)
                                Text("@\("anissa")")
                                    .foregroundColor(.aYellow)
                                    .onTapGesture {
                                        self.show.toggle()
                                    }
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
                                
                                Alert(title: Text("Request Sent!"), message: Text("Succesfully sent \("anissa") an attention request!"), dismissButton: .default(Text("Got it!")))
        //                        (session.session?.lastConversation) ?? "nil"
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
            
            if self.show {
                GeometryReader{ geometry in
                    VStack {
                        VStack {
                            PoplistView()
                            Button(action: {
                                self.show.toggle()
                            }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .foregroundColor(Color.black)
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .padding(20)
                            })
                            .background(Color.white)
                            .clipShape(Circle())
                        }
                    }
                    .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                }.background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
            }
            
        }
        
        
    }
}

struct PoplistView: View {
    var body : some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0..<25, id: \.self) { i in
                    ZStack(alignment: .trailing) {
                        HStack {
                            Image("anissagram").resizable()
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("@ranchgod\(i)").fontWeight(.semibold)
                                Text("Hello reese")
                                Divider()
                            }
                            .padding(.top)

                        }
                        Image(systemName: "arrow.right").foregroundColor(.gray)
                    }

                }
            }
            .padding()
        }
        .background(Color.white)
        .frame(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - 250 , alignment: .center)
    }
}

struct LoveView_Previews: PreviewProvider {
    static var previews: some View {
        LoveView()
    }
}
