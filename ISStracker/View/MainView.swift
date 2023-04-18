import SceneKit
import SwiftUI

struct MainView: View {
    @State var sceneISS: SCNScene? = .init(named: "ISS.usdz")
    @State var sceneEarth: SCNScene? = .init(named: "Earth.usdz")
    @EnvironmentObject var locationViewModel: ISSLocationViewModel
    @State var navigateToMapView = false
    @State var navigateToCrewView = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authService: FireStoreAuthService
    @EnvironmentObject var earthSceneViewModel: EarthSceneViewModel
    
    @State var navigateToSettingsView = false 
    
    var body: some View {
        NavigationView{
            TabView(){
                ZStack{
                    EarthSceneView(scene: $sceneEarth)
                        .environmentObject(earthSceneViewModel)
                        .onTapGesture {
                            navigateToMapView = true
                        }
                    VStack{
                        IssSceneView(scene: $sceneISS)
                            .frame(height: 350)
                            .onTapGesture {
                                navigateToCrewView = true
                            }
                        
                    }
                    .padding()
                    .background(NavigationLink(destination: AstronautsListView(), isActive: $navigateToCrewView){})
                }
                .background(NavigationLink(destination: LocationMapView(), isActive: $navigateToMapView){})

                .tabItem{
                    Label("ISS Location", systemImage: "")
                }
            }
            .navigationBarTitle("ISS Tracker", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    HStack {
                        Button(action: {
                            navigateToSettingsView = true
                        }) {
                            Image(systemName: "gear")
                        }
                        Button(action: {
                            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                            authService.signOut()
                        }) {
                            Text("Logout")
                                .foregroundColor(.red)
                        }
                    }
            )
            .sheet(isPresented: $navigateToSettingsView) {
                SettingsView()
            }
            
        }
    }
}

