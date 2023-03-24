//
//  ContentView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 20.02.23.
//

import SwiftUI



struct ContentView: View {
    
    @EnvironmentObject var authService: FireStoreAuthService
    @EnvironmentObject var issLocationViewModel: ISSLocationViewModel
    
    @State var password: String = ""
    @State var email: String = ""
    
    var body: some View {
        HStack{
            if authService.user != nil {
                MainView()
            }else {
                SpaceLoginView()
            }
        }.onAppear{
            
            authService.listenToAuthState()
        }
    }
  
}
    


