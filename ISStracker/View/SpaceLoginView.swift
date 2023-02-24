//
//  SpaceLoginView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 23.02.23.
//

import SwiftUI


struct SpaceLoginView: View {
    @EnvironmentObject var authService: AuthService
    @State private var email = ""
    @State private var password = ""
    @State private var loginFailed: Bool = false
    @State private var registerFailed: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Image("space-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text("WHERE IS THE ISS?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .bold()
                        .italic()
                    Spacer()
                    VStack(spacing: 16) {
                        TextField("Email", text: $email)
                            .padding()
                            .frame(width: 300, height: 50.0 )
                            .background(Color.white)
                            .cornerRadius(5.0)
                        
                        Divider()
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 300, height: 50.0 )
                            .background(Color.white)
                            .cornerRadius(5.0)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    Button(action: {
                        authService.signIn(email: email, password: password)
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                    }
                    
                    NavigationLink("Register"){
                        RegistrationView()
                    }
                    
                }
                
                Spacer()
            }
            .alert(isPresented: $loginFailed) {
                Alert(title: Text("Login failed"), message: Text("The username or password is incorrect."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct SpaceLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceLoginView()
    }
}
