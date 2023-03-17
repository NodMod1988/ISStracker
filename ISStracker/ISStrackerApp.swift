//
//  ISStrackerApp.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 20.02.23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}



@main
struct ISStrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var globalAuthService: AuthService = AuthService(auth: FireStoreAuthService())
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel(authService: globalAuthService))
                
                
        }
    }
}
