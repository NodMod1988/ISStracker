//
//  MainView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 27.02.23.
//

import SwiftUI
import SceneKit



struct MainView: View {
    
    @State var sceneISS: SCNScene? = .init(named: "ISS.usdz")
    @State var sceneEarth: SCNScene? = .init(named: "Earth.usdz")
    @EnvironmentObject var locationViewModel: ISSLocationViewModel
    @State var navigateToMapView = false

    var body: some View {
        
        NavigationView{
            TabView(){
                ZStack{
                    EarthSceneView(scene: $sceneEarth)
                        .onTapGesture {
                            navigateToMapView = true
                        }
                    
                    VStack{
                        IssSceneView(scene: $sceneISS)
                            .frame(height: 350)
                    }
                    .padding()
                }
                .background(NavigationLink(destination: LocationMapView(), isActive: $navigateToMapView){

                })
                
              
                .tabItem{
                    Label("ISS Location", systemImage: "")
                }
       
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
