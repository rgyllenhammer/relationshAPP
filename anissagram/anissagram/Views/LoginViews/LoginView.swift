//
//  LoginView.swift
//  anissagram
//
//  Created by Reese Gyllenhammer on 12/23/20.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userName: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""

    
    @State private var loggedIn: Bool = false
    @EnvironmentObject var session: SessionStore
    
    var body: some View {

            NavigationView {
     
                VStack(spacing: 0){
                    Image("anissagram")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                    HStack {
                        Text("Don't have an account?")
                        NavigationLink(
                            destination:
                                VStack{
                                    VStack {
                                        HStack {
                                            Text("Register")
                                                .font(.largeTitle)
                                                .fontWeight(.bold)
                                            Spacer()
                                        }
                                        Image("anissagram")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .cornerRadius(20)
                                            .padding(.bottom)
                                        VStack{
                                            HStack{
                                                InputView(placeholder: "First Name", color: Color.aYellow, bindingText: $firstName)
                                                InputView(placeholder: "Last Name", color: Color.aYellow, bindingText: $lastName)
                                            }.padding(.top)
                                            InputView(placeholder: "Email", color: Color.aYellow, bindingText: $email)
                                            InputView(placeholder: "Username", color: Color.aYellow, bindingText: $userName)
                                            InputView(placeholder: "Password", color: Color.aYellow, bindingText: $password)
                                            Button(action: {
                                                signUp()
                                            }, label: {
                                                Text("Sign up")
                                                    .font(.title)
                                                    .padding()
                                                    .foregroundColor(.aYellow)
                                            })
                                        }.padding(.top)


                                    }.padding()
                                },

                            label: {
                                HStack{
                                    Text("Register")
                                    Image(systemName: "chevron.right")
                                }

                                .foregroundColor(.aYellow)
                            })
                    }.padding(.vertical)
                    
                    InputView(placeholder: "Email", color: Color.aRed, bindingText: $email)
                    InputView(placeholder: "Username", color: Color.aRed, bindingText: $userName)
                    InputView(placeholder: "Password", color: Color.aRed, bindingText: $password)
                    Button(action: {
                        logIn()
                    }, label: {
                        Text("Log in")
                            .font(.title)
                            .padding()
                            .foregroundColor(.aRed)
                    })

                }
                .navigationTitle("Log in")
                .padding()
                

            }
            .accentColor(.red)
            
        
        // TODO: create view that accepts email/password and allows users to login or signup
        // You'll need a NavigationView and VStacks
    }
    
    // TODO: Log in an existing user to Firebase Authentication
    func logIn() {
        print("user log in")
        session.signIn(email: email, password: password, userName: userName)
    }
    
    // TODO: Sign up a new user to Firebase Authentication
    func signUp() {
        // TODO validate entries
        print("user sign up")
        session.signUp(email: email, password: password, userName: userName, firstName: firstName, lastName: lastName)
    }
    
    // TODO: Implement more rigorous checks
    func validEntries() -> Bool {
        if (email != "" && password != "") { return true }
        return false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct InputView : View {
    var placeholder: String
    var color : Color
    @Binding var bindingText: String
    @State var clicked = false
    
    var body: some View {
        VStack{
            TextField(placeholder, text: $bindingText, onEditingChanged: {edit in clicked = edit})
                .autocapitalization(.none)
                .font(.title2)
            HorizontalLine(color: clicked ? color : Color.gray, height: 2.0)
        }
        .padding(.bottom)
        

    }
}
