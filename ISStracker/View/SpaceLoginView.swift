//
//  SpaceLoginView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 23.02.23.
//

import SwiftUI


struct SpaceLoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var loginFailed: Bool = false
    @State private var registerFailed: Bool = false

        
        var body: some View {
            ZStack {
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
                        TextField("Username", text: $username)
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
                        if self.username == "admin" && self.password == "1234" {
                            // Login erfolgreich
                            self.loginFailed = false
                        } else {
                            // Login fehlgeschlagen
                            self.loginFailed = true
                        }
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                    }
                    
                    Button(action: {
                        if self.username == "admin" && self.password == "1234" {
                            // Login erfolgreich
                            self.loginFailed = false
                        } else {
                            // Login fehlgeschlagen
                            self.loginFailed = true
                        }
                    }) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                            
                    }
                }
                
                Spacer()
            }
            .alert(isPresented: $loginFailed) {
                Alert(title: Text("Login failed"), message: Text("The username or password is incorrect."), dismissButton: .default(Text("OK")))
            }
        }
    }

struct SpaceLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceLoginView()
    }
}
