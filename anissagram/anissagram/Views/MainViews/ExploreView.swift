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
    
    @State var currentlyDisplaying : String = .relations
    
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
                    
                            
                            Button(action: {session.signOut()}, label: {
                                Image(systemName: "gearshape")
                                    .foregroundColor(.aRed)
                                    .font(.title2)
                                
                            })
                            
                            
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
                        Button {
//                            withAnimation {
                                self.currentlyDisplaying = .relations
//                            }
                        } label: {
                            NewGridItem(width: calculateWidth(pad: 10), color: .aRed, text: .relations, numberToDisplay: numberRelations, isDisplaying: $currentlyDisplaying)
                        }
                        
                        Button {
//                            withAnimation {
                                self.currentlyDisplaying = .pending
//                            }
                        } label: {
                            NewGridItem(width: calculateWidth(pad: 10), color: .aOrange, text: .pending, numberToDisplay: numberPending, isDisplaying: $currentlyDisplaying)
                        }
                        
                        Button {
//                            withAnimation {
                                self.currentlyDisplaying = .requests
//                            }

                        } label: {
                            NewGridItem(width: calculateWidth(pad: 10), color: .aYellow, text: .requests, numberToDisplay: numberRequests, isDisplaying: $currentlyDisplaying)
                        }

                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text(currentlyDisplaying)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    UserDisplays(currentDisplay: currentlyDisplaying, session: session)
                    
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

struct UserDisplays : View {
    
    var currentDisplay : String
    var names : [String]
    @EnvironmentObject var session : SessionStore
    
    init(currentDisplay: String, session: SessionStore) {
        self.currentDisplay = currentDisplay
        
        if (currentDisplay == .relations) {
            names = session.session?.relationships.allKeys as? [String] ?? []
        } else if (currentDisplay == .pending) {
            names = session.session?.pending.allKeys as? [String] ?? []
        } else {
            names = session.session?.requests.allKeys as? [String] ?? []
        }
        
    }
    
    var body: some View {
        if (names.count == 0) {
            NothingToDisplayView()
        } else {
            ForEach(names, id: \.self) { name in
                SearchResultItem(name: name).environmentObject(session)
            }
        }
    }
}


struct NewGridItem : View {
    var width: CGFloat
    var color: Color
    var text: String
    var numberToDisplay: Int
    
    @Binding var isDisplaying : String

    var body: some View {

        VStack{
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
            
            HorizontalLine(color: isDisplaying == text ? color : Color.clear, height: 2.0)
            
            
        }

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
            
            // buttons decided based on relationship to user
            HStack{
                // currently in relationship
                if (session.isInRelationship(with: name)) {
                    
                    Button {
                        session.deleteRelationShip(with: name)
                    } label: {
                        Text("Delete")
                            .foregroundColor(.gray)
                    }

                // sent a request to name but they have ot replied
                // perhaps there is an optimization here as this is the exact OPPOSITE if we have never sent a relationship
                } else if (session.isPendingRelationship(with: name)) {
                    
                    Button {
                        session.deletePending(with: name)
                    } label: {
                        VStack{
                            Text("Unsend").foregroundColor(.gray)
                        }
                    }
                    
                // name has sent us a request but we have not replied
                } else if (session.isRequestedRelationship(from: name)) {
                    
                    Button {
                        // should be the same as addRelationship
                        session.acceptRequest(from: name)
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.aRed)
                    }
                    
                    Button {
                        session.declineRequest(from: name)
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.aYellow)
                    }

                    
                // not in any form of a relationship with name
                } else {
                    Button {
                        if (toggled) {
                            session.deletePending(with: name)
                        } else {
                            session.addPending(with: name)
                        }
                        
                        toggled.toggle()
                        
                    } label: {
                        VStack{
                            toggled ? Text("Unsend").foregroundColor(.gray) : Text("Add").foregroundColor(.aRed)
                        }
                    }
                }
                
            }
        }
    }
}



struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
