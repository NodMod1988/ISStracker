//
//  ContentView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 20.02.23.
//

import SwiftUI



struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel

    @State var password: String = ""
    @State var email: String = ""
    
    var body: some View {
        HStack{
            if authViewModel.authService.auth.getUser() != nil{
                MainView()
            }else {
                SpaceLoginView()
            }
        }.onAppear{
            
            authViewModel.authService.listenToAuthState()
        }
    }
  
}
    


