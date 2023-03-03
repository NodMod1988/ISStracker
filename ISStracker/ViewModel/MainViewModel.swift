//
//  MainViewModel.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 23.02.23.
//

import Foundation

@MainActor class MainViewModel : ObservableObject{

    var authService: AuthService
    var dataService: DataService
    
    init(authService: AuthService, dataService: DataService) {
        self.authService = authService
        self.dataService = dataService
    }
    

    func signUp(email: String, password: String){
        authService.signUp(email: "", password: "")
    }
    
}
