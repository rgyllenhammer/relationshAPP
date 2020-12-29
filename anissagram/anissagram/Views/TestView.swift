
//  TestView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 12/27/20.


import SwiftUI

struct TestView: View {
    @State var userTerm = ""
    @State var showingUseers = false
    var names = ["reese", "ranchgod", "anissa", "jadyn", "jaqueline", "reese2"]

    var body: some View {
        VStack{
            SearchBar(userTerm: $userTerm, showingUsers: $showingUseers)
            ZStack {
                ScrollView {
                    HStack{
                        Text("Happy Birthday Anissa!").font(.largeTitle).fontWeight(.bold)
                        Spacer()
                    }.padding(.top)
                    HStack {
                        Text("You are probably wondering what this app does, so I will break it down by each tab.")
                        Spacer()
                    }.padding(.bottom).foregroundColor(.gray)
                }
                SearchResults(userTerm: $userTerm, showingUsers: $showingUseers, names: names)
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct SearchBar : View {

    @Binding var userTerm : String
    @Binding var showingUsers : Bool
    
    func hideKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }


    var body: some View {
        VStack {
            HStack {
                TextField("Search users ...", text: $userTerm)
                    .padding(.all, 10)
                    .font(.title3)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5)
//                    .padding()
                if (self.showingUsers) {
                    Button(action: {
                        self.showingUsers = false
                        self.userTerm = ""
                        self.hideKeyBoard()
                    }, label: {
                        Text("Cancel").font(.title3)
                    })
                    .padding(.trailing)
                }
            }.onTapGesture {
                self.showingUsers = true
            }
        }
    }
}

struct SearchResults : View {

    @Binding var userTerm : String
    @Binding var showingUsers : Bool
    var names : [String]


    var body: some View {
        if (self.showingUsers && !self.userTerm.isEmpty) {
            ScrollView{
                ForEach((names).filter({$0.contains(userTerm.lowercased())}), id: \.self) { name in
                    HStack {
                        Image("anissagram").resizable()
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("@\(name)").fontWeight(.semibold)
                            Text("Choose Relationship")
                            Divider()
                        }
                        .padding(.top)

                    }
//                    .padding(.horizontal)
                }
            }.background(Color.white)
        }
    }
}



struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
