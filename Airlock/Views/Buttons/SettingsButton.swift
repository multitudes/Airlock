//
//  SettingsButton.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

struct SettingsButton: View {

    @Binding var showModal: Bool
    
    var body: some View {
        Button(action: {
            print("Button Pushed")
            self.showModal = true
        }) {
            Image(systemName: "gear").foregroundColor(.white)

        }.sheet(isPresented: $showModal) {
            SettingsView()
           }.accessibility(label:Text("Settings"))
    }
}


