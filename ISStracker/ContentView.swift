//
//  ContentView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 20.02.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authService: AuthService
    var body: some View {
        Group{
            if authService.user != nil{
                RegistrationView()
            }else {
                SpaceLoginView()
            }
        }.onAppear{
            authService.listenToAuthState()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthService())
    }
}
