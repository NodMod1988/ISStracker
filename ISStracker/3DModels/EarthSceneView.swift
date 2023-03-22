//
//  EarthSceneView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 22.03.23.
//

import SwiftUI
import SceneKit

struct EarthSceneView: UIViewRepresentable {
    
    @Binding var scene: SCNScene?

    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
        
        let rotateAction = SCNAction.repeatForever(SCNAction.rotate(by: .pi, around: SCNVector3(x:0, y:1, z:0), duration: 30))
        view.scene?.rootNode.runAction(rotateAction)


        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
    }
    
    
 
}

struct EarthSceneView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
