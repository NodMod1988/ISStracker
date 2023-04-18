//
//  SettingsView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 18.04.23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var earthSceneViewModel: EarthSceneViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Earth Rotation Speed")) {
                    Slider(value: $earthSceneViewModel.earthRotationSpeed, in: 1...100, step: 5)
                }
            }
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
