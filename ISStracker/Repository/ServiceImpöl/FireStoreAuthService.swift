import Foundation
import FirebaseAuth

final class FireStoreAuthService: ObservableObject{
    
    
    var user: User?{
        didSet{
            objectWillChange.send()
        }
    }
    
    
    func listenToAuthState(){
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else{
                return
            }
            self.user = user
        }
    }
    
    func signUp(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password){result, error in
            if let error = error {
                print("an error occured \(error)")
                return
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Sign in failed: \(error)")
                return
            }
            print("User signed in")
        }
    }

    
    func signOut(){
        do{
            try Auth.auth().signOut()
        }catch let error{
            print("an error occured \(error)")
        }
    }
}
