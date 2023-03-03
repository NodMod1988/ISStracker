//
//  ContentView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 20.02.23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var mainviewModel : MainViewModel
    
    var body: some View {
        Group{
            if mainviewModel.authService.user != nil{
                RegistrationView()
            }else {
                SpaceLoginView()
            }
        }.onAppear{
            mainviewModel.authService.listenToAuthState()
        }
    }
        .Environment(MainViewModel(authService: FireStoreAuthService, dataService: Data))
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authService: FireStoreAuthService())
    }
}
