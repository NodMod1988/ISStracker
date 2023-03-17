//
//  AuthService.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 17.03.23.
//

import Foundation
import FirebaseAuth

final class AuthService: ObservableObject{
    
    var auth: AuthProtocoll
    
    init(auth: AuthProtocoll) {
        self.auth = auth
    }
    
    func getUser()->User{
        return auth.getUser()
        
    }
    
    func listenToAuthState(){
        auth.listenToAuthState()
    }
    
    func signUp(email: String, password: String){
        auth.signUp(email: email, password: password)
    }
    
    func signIn(email: String, password: String){
        auth.signIn(email: email, password: password)
    }
    
    func signOut(){
        auth.signOut()
    }
    
 
    
}
