//
//  RegistrationView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 24.02.23.
//

import SwiftUI

struct RegistrationView: View {
    
    @EnvironmentObject var authService: FireStoreAuthService
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
        
            Image("space-background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            Spacer()
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            VStack(spacing: 16) {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                
            }
            .padding(.horizontal)
            Button(action: {
                authService.signUp(email: email, password: password)
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            Spacer()
        }
    }
}

