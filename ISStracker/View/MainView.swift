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

    var body: some View {
        ZStack{
            EarthSceneView(scene: $sceneEarth)
                
            VStack{
                IssSceneView(scene: $sceneISS)
                    .frame(height: 350)
      

            }
            .padding()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
