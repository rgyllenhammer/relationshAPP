//
//  InfoView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/25/20.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var userToText : User
    @State var showingAlertAnissa = false
    @State var showingAlertReese = false
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("Happy Birthday Anissa!").font(.largeTitle).fontWeight(.bold)
                    Spacer()
                }.padding(.top)
                HStack {
                    Text("You are probably wondering what this app does, so I will break it down by each tab.")
                    Spacer()
                }.padding(.bottom).foregroundColor(.gray)
                HStack{
                    Text("Tabs").font(.title).fontWeight(.bold)
                    Spacer()
                }.padding(.top)
                
                CardView(opened: false, tabName: "Info Tab", imageName: "heart.fill", color: .red, text: "This is the idea that started the app honestly. Your bitchass needed a little button you could press to specifically get my attention and I was like you know what ... I could just make that. So I did. I am writing this early on in the app development process but if I am grumpy at the end of this than it was harder to make than I thought. Anyways, you just press the button as many times as you want and when you send them to me I will get a push notification with how many love points you need. Just know I can send them back too. Hopefully the clicking is really addicting so it can be like cookie clicker where you send me scores in the millions or something.")
                CardView(opened: false, tabName: "Food Tab", imageName: "car", color: Color(red: 254/255, green: 97/255, blue: 43/255, opacity: 1), text: "I got hyped on the idea of turning this into a pure Anissa app where whenever you have a strange need or want I can just put it in the app and update it so that you can have it and this was the first thing that came to mind when I thought of doing that. A huge struggle we have is choosing what to goddamn eat when we are going to go out so I decided that this way we can add a bunch of restaurants to choose from and then have it randomly pick for us. That way if it shows something and we arent hyped on it then we can easily eliminate that from the list, but if we actually 'dont care' like we say we do then it should not be a problem if it says a restaurant we don't typically eat at.")
                CardView(opened: false, tabName: "Mems Tab", imageName: "figure.wave", color: .orange, text: "It should be clear when you open it up what it is for, but hopefully it is a cute collage of pictures or videos of us that you can scroll through and look at whenver you want. I am not sure currently how it will look as I am writing this before I have actually built it but I hope that it is easy to look at and not too fucking ugly or anything. I have a shit load more videos and pictures of us than you think so I really hope that a few of them you havnt seen before and they make u cry. You'll also be able to log out and shit here but I hope you never log out so I can send you i love you notifs every goddamn day.")
                
                HStack{
                    Text("Choose User").font(.title).fontWeight(.bold)
                    Spacer()
                }.padding(.top)
                HStack {
                    Text("Choose who is using the app! It will be used in the Love Tab section of the app")
                    Spacer()
                }.padding(.bottom).foregroundColor(.gray)
                HStack{
                    Button(action: {
                        userToText.sendTo = "reese"
                        userToText.sendFrom = "anissa"
                        showingAlertAnissa = true
                    }, label: {
                        Text("Anissa R.")
                    }).font(.title).foregroundColor(.red)
                    .alert(isPresented: $showingAlertAnissa) {
                        Alert(title: Text("Choosing: Anissa"), message: Text("You may change this at any point"), dismissButton: .default(Text("Got it!")))
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        userToText.sendTo = "anissa"
                        userToText.sendFrom = "reese"
                        showingAlertReese = true
                    }, label: {
                        Text("Reese G.")
                    }).font(.title).foregroundColor(.orange)
                    .alert(isPresented: $showingAlertReese) {
                        Alert(title: Text("Choosing: Reese"), message: Text("You may change this at any point"), dismissButton: .default(Text("Got it!")))
                    }
                }
                
   
            }.padding()
        }
    }
}

struct CardView: View{
    
    @State var opened: Bool
    var tabName: String
    var imageName: String
    var color: Color
    var text: String
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Image(systemName: opened ? "chevron.down": "chevron.right")
                Text(tabName).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Image(systemName: imageName).font(.system(size: 20))
                Spacer()
            }
            .padding()
        
            .onTapGesture {
                withAnimation{
                    opened.toggle()
                }
            }
            
            if (opened){
                Text(text).padding()
            }
            
        }
        .background(color)
        .foregroundColor(Color.white)
        .padding(.bottom)
        .cornerRadius(10)
        
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
