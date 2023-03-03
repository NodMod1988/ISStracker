//
//  AuthService.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 27.02.23.
//

import Foundation

protocol AuthService{
    
    func listenToAuthState()
    
    func signUp(email: String, password: String)
    
    func signIn(email: String, password: String)
    
    func signOut()
}
