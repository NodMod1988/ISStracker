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
    var body: some View {
        
        TabView{
            ZStack{
                EarthSceneView(scene: $sceneEarth)
                
                VStack{
                    IssSceneView(scene: $sceneISS)
                        .frame(height: 350)
                    
                    
                }
                .padding()
            }
            
            
            LocationMapView()
                .tabItem{
                    Label("Click me", systemImage: "")
                }
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
