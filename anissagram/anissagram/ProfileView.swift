//
//  ProfileView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 11/24/20.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        ScrollView{
            LazyVStack{
                HStack{
                    Text("Photos for you!").font(.largeTitle).fontWeight(.bold)
                    Spacer()
                }.padding(.top)
                HStack {
                    Text("Well it turns out it is much harder to get a lot of pictures into an iphone than I thought so I guess you will have to live with a few good ones. I love you so much bitch.")
                    Spacer()
                }.padding(.bottom).foregroundColor(.gray)
                
                Group{
                    Image("beautiful")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .cornerRadius(20)

                    HStack {
                        Text("December 7, 2019 - Showing me the Beatles").font(.caption)
                        Spacer()
                    }.padding(.bottom).foregroundColor(.black)
                    HStack {
                        Text("No matter how hard you try to mess up a photo it just is never going to work and this is proof of it. I know you hate being serious for the camera so you try and make an ugly face to blah blah blah but this I remember taking this and thinking about how jealous other bitches should probably be because u have to TRY to look ugly in a photo, but if I take it before you are ready it is clear to see how easy it is for you to look beautiful")
                        Spacer()
                    }.padding(.bottom).foregroundColor(.gray)
                }
                
                Group{
                    Image("ethereal2").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    HStack {
                        Text("September 20, 2020 - Taking pictures of eachother").font(.caption)
                        Spacer()
                    }.padding(.bottom).foregroundColor(.black)
                    HStack {
                        Text("You were hella mad at me because I dont take enough pictures of you because you spent most of this golden hour taking pictures of me hahahaha. Tough tits bitch I looked amazing. I guess the only problem is you did too. That honestly isnt even why I like this picture so much though I like it because it reminds me of when we spend a full fucking day together and then the sun is starting to go down and we are going to spend the night together. Yeah we might get a little snappy if we hangout for a bunch of days in a row but spending a whole day with you is my favorite thing on the fucking planet, and I never forget how lucky I am that I get to do it.")
                        Spacer()
                    }.padding(.bottom).foregroundColor(.gray)
                }
                
                Group{
                    Image("hammock").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    HStack {
                        Text("May 17, 2020 - Love Bundle 1").font(.caption)
                        Spacer()
                    }.padding(.bottom).foregroundColor(.black)
                    HStack {
                        Text("I dont even need to say why this is one of my favorite pictures. This love bungalo was way more fire than anything else. We got horny, napped, made out, napped again, and just enjoyed our afternoon without worrying about anything. School was out but work hadn't started yet, we had nothing to worry about but eachother. I love feeling that way with you. I know you love summer Reese, but I love summer anissa as well. Can I get head in Love Bundle 2 though?")
                        Spacer()
                    }.padding(.bottom).foregroundColor(.gray)
                }
                
                Group{
                    Image("selfie2").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    HStack {
                        Text("July 30, 2020 - Vacation").font(.caption)
                        Spacer()
                    }.padding(.bottom).foregroundColor(.black)
                    HStack {
                        Text("I dont know how you think we look in this but I think we look like the hottest fucking couple there is. We fucked 10 minutes before and after taking this picture, so I was off some post sex glow for sure. Our vacation was so fun Anissa. We literally fucking car tripped to get my bitchass a tattoo and just fucked and cried and ate chocolate covered almonds all we wanted. I feel like kind of a bitch for writing so much to you right now like i hope this doesnt come off as too corny but ... thinking about this vacation just makes me want to take more with you. Sometimes I feel its easy to tell how made we are for eachother when we aren't in Berkeley and we are around people we don't know. I feel like when those people look at us without knowing us its easy to tell how much I love you and you love me")
                        Spacer()
                    }.padding(.bottom).foregroundColor(.gray)
                }
//                Group{
//                    Image("us").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
//                    HStack {
//                        Text("November 12, 2018 - Us").font(.caption)
//                        Spacer()
//                    }.padding(.bottom).foregroundColor(.black)
//                    HStack {
//                        Text("And last but not least we cannot forget how we started. Yeah I know you want to be less jokey and you know I am always down. But bitch sometimes I just wanna shart in your fucking bed and suck your girthy fucking toe pad, and I FUCKING KNOW you love me for that. How do I know??? Because sometimes you wanna do the same to me. I fucking know it, and I fucking love you for it. I'll love you for a lot of things.")
//                        Spacer()
//                    }.padding(.bottom).foregroundColor(.gray)
//                }
                
                VStack{
                    HStack{
                        Text("Happy birthday dear,").font(.largeTitle).fontWeight(.bold)
                        Spacer()
                    }
                    HStack{
                        Text("I love you.").font(.largeTitle).fontWeight(.bold)
                        Spacer()
                    }
                    
                }

                
                
                
            }.padding()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
