//
//  MainViewModel.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 23.02.23.
//

import Foundation

@MainActor class AuthViewModel : ObservableObject{

    var authService: AuthService 
    
    init(authService: AuthService) {
        self.authService = authService
    }

    


}
