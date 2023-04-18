//
//  EarthSceneViewModel.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 18.04.23.
//

import Foundation

class EarthSceneViewModel: ObservableObject {
    @Published var earthRotationSpeed: Double {
        didSet {
            UserDefaults.standard.set(earthRotationSpeed, forKey: "earthRotationSpeed")
            updateEarthRotation()
        }
    }
    
    init() {
        self.earthRotationSpeed = UserDefaults.standard.object(forKey: "earthRotationSpeed") as? Double ?? 20
        updateEarthRotation()
    }
    
    func updateEarthRotation() {
        objectWillChange.send()
    }
}
