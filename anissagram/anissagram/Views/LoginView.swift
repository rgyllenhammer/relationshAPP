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
                    // sign in nav link
//                    ZStack{
//                        Image("snapagram_logo").resizable()
//                    }.frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
//                    Spacer()
                    Image("anissagram")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                    HStack {
                        Text("Already have an account?")
                        NavigationLink(
                            destination: VStack{
                                VStack {
                                    HStack {
                                        Text("Log in")
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
                                        InputView(placeholder: "Email", color: Color.aYellow, bindingText: $email)
                                        InputView(placeholder: "Username", color: Color.aYellow, bindingText: $userName)
                                        InputView(placeholder: "Password", color: Color.aYellow, bindingText: $password)
                                        Button(action: {
                                            logIn()
                                        }, label: {
                                            Text("Log In")
                                                .font(.title)
                                                .padding()
                                                .foregroundColor(.aYellow)
                                        })
                                    }.padding(.top)
    
                                    
                                }.padding()
                            },
                            
                            label: {
                                HStack{
                                    Text("Log in")
                                    Image(systemName: "chevron.right")
                                }
                                
                                .foregroundColor(.aYellow)
                            })
                    }.padding(.vertical)
                    
                    
                    HStack{
                        InputView(placeholder: "First Name", color: Color.aRed, bindingText: $firstName)
                        InputView(placeholder: "Last Name", color: Color.aRed, bindingText: $lastName)
                    }.padding(.top)
                    InputView(placeholder: "Email", color: Color.aRed, bindingText: $email)
                    InputView(placeholder: "Username", color: Color.aRed, bindingText: $userName)
                    InputView(placeholder: "Password", color: Color.aRed, bindingText: $password)
                    Button(action: {
                        signUp()
                    }, label: {
                        Text("Sign Up")
                            .font(.title)
                            .padding()
                            .foregroundColor(.aRed)

                    })
                    
                    Spacer()
                    
//                    NavigationLink(
//                        destination:
//                            VStack{
//                                FormView(signingIn: true, email: $email, password: $password)
//
//                                Button(action: {logIn()}, label: {
//                                    Text("Submit")
//                                }).background(Color.blue).foregroundColor(.white)
//                            }
//                        ,label: {
//                            ButtonView(signingIn: true)
//                        })
                    
                    
                    // sign up nav link
//                    NavigationLink(
//                        destination:
//                            VStack{
//                                FormView(signingIn: false, email: $email, password: $password)
//                                TextField("Username", text: $userName)
//                                TextField("First Name", text: $firstName)
//                                TextField("Last Name", text: $lastName)
//
//                                Button(action: {signUp()}, label: {
//                                    Text("Submit")
//                                }).background(Color.red).foregroundColor(.white)
//                            }
//
//                        ,label: {
//                            ButtonView(signingIn: false)
//                        })
                }
                .padding()
                .navigationTitle("Register")
            }.accentColor(.red)
            
        
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

struct FormView : View {
    var signingIn : Bool
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        
        VStack{
            Text(signingIn ? "LOG IN" : "SIGN UP")

            TextField("Email", text: $email)
            TextField("Password", text: $password)
        }.foregroundColor(signingIn ? Color.red : Color.blue)

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
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .font(.title)
            HorizontalLine(color: clicked ? color : Color.gray, height: 2.0)
        }
        .padding(.bottom)
        

    }
}

struct HorizontalLineShape: Shape {

    func path(in rect: CGRect) -> Path {

        let fill = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        var path = Path()
        path.addRoundedRect(in: fill, cornerSize: CGSize(width: 2, height: 2))

        return path
    }
}

struct HorizontalLine: View {
    private var color: Color? = nil
    private var height: CGFloat = 1.0

    init(color: Color, height: CGFloat = 1.0) {
        self.color = color
        self.height = height
    }

    var body: some View {
        HorizontalLineShape().fill(self.color!).frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height)
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
