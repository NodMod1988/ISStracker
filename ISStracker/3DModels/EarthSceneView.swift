//
//  EarthSceneView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 22.03.23.
//

import SwiftUI
import SceneKit

struct EarthSceneView: UIViewRepresentable {
    @EnvironmentObject var earthSceneViewModel: EarthSceneViewModel

    @Binding var scene: SCNScene?
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()

        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
        
        let rotateAction = SCNAction.repeatForever(SCNAction.rotate(by: .pi, around: SCNVector3(x: 0, y: 1, z: 0), duration: earthSceneViewModel.earthRotationSpeed))
        view.scene?.rootNode.runAction(rotateAction)

        let poi = SCNNode()
        poi.position = SCNVector3(x: 0, y: 0, z: 0)
        view.pointOfView?.addChildNode(poi)

        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        uiView.scene = scene
        let rotateAction = SCNAction.repeatForever(SCNAction.rotate(by: .pi, around: SCNVector3(x: 0, y: 1, z: 0), duration: earthSceneViewModel.earthRotationSpeed))
        uiView.scene?.rootNode.runAction(rotateAction)
    }
}
