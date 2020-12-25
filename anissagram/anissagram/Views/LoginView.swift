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
    
    @State private var loggedIn: Bool = false
    @EnvironmentObject var session: SessionStore
    
    var body: some View {


            NavigationView {
     
                VStack(spacing: 0){
                    // sign in nav link
//                    ZStack{
//                        Image("snapagram_logo").resizable()
//                    }.frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                    
                    NavigationLink(
                        destination:
                            
                            VStack{
                                FormView(signingIn: true, email: $email, password: $password)
                                
                                Button(action: {logIn()}, label: {
                                    Text("Submit")
                                }).background(Color.blue).foregroundColor(.white)
                            }
                        ,label: {
                            ButtonView(signingIn: true)
                        })
                    
                    
                    // sign up nav link
                    NavigationLink(
                        destination:
                            VStack{
                                FormView(signingIn: false, email: $email, password: $password)
                                
                                Button(action: {signUp()}, label: {
                                    Text("Submit")
                                }).background(Color.red).foregroundColor(.white)
                            }
                            
                        ,label: {
                            ButtonView(signingIn: false)
                        })
                }
            }
            
        
        // TODO: create view that accepts email/password and allows users to login or signup
        // You'll need a NavigationView and VStacks
    }
    
    // TODO: Log in an existing user to Firebase Authentication
    func logIn() {
        print("user log in")
        session.signIn(email: email, password: password)
    }
    
    // TODO: Sign up a new user to Firebase Authentication
    func signUp() {
        print("user sign up")
        session.signUp(email: email, password: password)
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

struct FormView : View {
    var signingIn : Bool
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        
        VStack{
            Text(signingIn ? "LOG IN" : "SIGN UP")

            TextField("Username", text: $email)
            TextField("Password", text: $password)
        }.foregroundColor(signingIn ? Color.red : Color.blue)

    }
    
}

struct ButtonView : View {
    var signingIn : Bool
    
    var body: some View {
        
        ZStack{
            Text(signingIn ? "Sign In" : "Sign Up")
        }.foregroundColor(.white).frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(signingIn ? Color.red : Color.blue).cornerRadius(20)
        

        
    }
    
    
}
