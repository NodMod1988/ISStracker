
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
    

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(FireStoreAuthService())
                .environmentObject(ISSLocationViewModel())
                .environmentObject(UserLocationViewModel())
                .environmentObject(EarthSceneViewModel())
                
            
        }
    }
}
