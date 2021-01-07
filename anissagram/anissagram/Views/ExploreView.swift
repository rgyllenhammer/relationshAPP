//
//  TestView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 12/27/20.

import SwiftUI

struct ExploreView: View {
    // STATE CONSTANTS
    @State var userTerm = ""
    @State var showingUseers = false
    @State var names : [String] = []
    
    // hopefully one day these can be erased and we can detect changes on the user object
    @State var numberRelations = 0
    @State var numberPending = 0
    @State var numberRequests = 0
    
    // ENVIRONMENT OBJECTS
    @EnvironmentObject var session : SessionStore
    
    // VIEW RELATED FUNCTIONS
    func calculateWidth(pad: CGFloat) -> CGFloat {
        return (UIScreen.main.bounds.width - (pad * 4)) / 3
    }

    var body: some View {
        VStack{
            SearchBar(userTerm: $userTerm, showingUsers: $showingUseers, names: $names)
            ZStack {
                ScrollView {
                        HStack{
                            Text(session.session?.userName ?? .loading)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                        }.padding(.top)

                    HStack{
                        Image("anissagram")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(Circle())

                        VStack {
                            HStack{
                                Text(session.session?.fullName ?? .loading)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                            }

                            HStack {
                                Text("Im a savage yeah, classy, boujee, ratchet, yeah. Megan the stallion.")
                                Spacer()
                            }
                            .padding(.bottom)
                            .foregroundColor(.gray)

                        }

                    }
                    .padding(.bottom)
                    HStack {
                        NewGridItem(width: calculateWidth(pad: 10), color: .aRed, text: "Relations", numberToDisplay: numberRelations)
                        NewGridItem(width: calculateWidth(pad: 10), color: .aOrange, text: "Pending", numberToDisplay: numberPending)
                        NewGridItem(width: calculateWidth(pad: 10), color: .aYellow, text: "Requests", numberToDisplay: numberRequests)
                    }
                    .padding(.bottom)

                }
                SearchResults(userTerm: $userTerm, showingUsers: $showingUseers, names: names).environmentObject(session)
            }
            Spacer()
        }
        .padding(.horizontal)
        .onAppear(perform: {
            if let user = session.session {
                numberRelations = user.relationships.count
                numberRequests = user.requests.count
                numberPending = user.pending.count
            }
        })
        .onReceive(session.didChange) { (newSession) in
            if let newUser = newSession.session {
                numberRelations = newUser.relationships.count
                numberRequests = newUser.requests.count
                numberPending = newUser.pending.count
            }
        }
    }
}

struct NewGridItem : View {
    var width: CGFloat
    var color: Color
    var text: String
    var numberToDisplay: Int

    var body: some View {
        VStack {
            VStack {
                Text("\(numberToDisplay)")
                    .font(.title)
                    .fontWeight(.bold)
                Text(text)
            }
        }
        .frame(width: width, height: width * 0.7, alignment: .center)
        .background(color)
        .cornerRadius(10.0)
        .foregroundColor(.white)

    }
}

struct SearchBar : View {

    @Binding var userTerm : String
    @Binding var showingUsers : Bool
    @Binding var names : [String]

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
                    .autocapitalization(.none)
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
                DatabaseManager.shared.downloadUsers() { users in
                    self.names = users
                }
            }
        }
    }
}

struct SearchResults : View {

    @Binding var userTerm : String
    @Binding var showingUsers : Bool
    var names : [String]
    @State var added = false
    @EnvironmentObject var session : SessionStore


    var body: some View {
        if (self.showingUsers && !self.userTerm.isEmpty) {
            ScrollView{
                ForEach((names).filter({$0.hasPrefix(userTerm.lowercased())}), id: \.self) { name in
                    SearchResultItem(name: name).environmentObject(session)
                }
            }.background(Color.white)
        }
    }
}

struct SearchResultItem : View {
    @State var toggled = false
    @EnvironmentObject var session : SessionStore
    var name : String
    
    var body: some View{
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
            
            Button(action: {
                if (!(session.isInRelationship(with: name) || toggled )) {
                    session.addRequest(with: name)
                }
                
                self.toggled = true
            }, label: {
                Text(session.isInRelationship(with: name) || toggled ? "Pending" : "Add")
            })
            .foregroundColor(session.isInRelationship(with: name) || toggled ? .gray : .aRed)
            .padding(.trailing)
        }
    }
}



struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
