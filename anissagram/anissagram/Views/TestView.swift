
//  TestView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 12/27/20.


import SwiftUI

struct TestView: View {
    @State var userTerm = ""
    var names = ["reese", "ranchgod", "anissa", "jadyn", "jaqueline", "reese2"]

    var body: some View {

        VStack{
            SearchBar(userTerm: $userTerm, names: names)
            Spacer()
        }
    }
}

struct SearchBar : View {

    @Binding var userTerm : String
    @State var showingUsers = false
    var names : [String]


    var body: some View {
        VStack {
            HStack {
                TextField("Search users ...", text: $userTerm)
                    .padding(.all, 10)
                    .font(.title2)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5)
                    .padding()
                if (self.showingUsers) {
                    Button(action: {
                        self.showingUsers = false
                        self.userTerm = ""
                    }, label: {
                        Text("Clear").font(.title3)
                    })
                    .padding(.trailing)
                }
            }.onTapGesture {
                self.showingUsers = true
            }
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

                        }.padding(.horizontal)
                    }
            }
            }

        }
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
