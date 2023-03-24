//
//  IssSceneView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 22.03.23.
//

import SwiftUI
import SceneKit

struct IssSceneView: UIViewRepresentable {

    @Binding var scene: SCNScene?

    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
        
        
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }

}

struct IssSceneView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
