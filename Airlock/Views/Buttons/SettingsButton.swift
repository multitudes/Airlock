//
//  SettingsButton.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

struct SettingsButton: View {
    
    @Binding var showModal: Bool
    var geo: GeometryProxy
    
    var body: some View {
        Button(action: {
            print("Button Pushed")
            self.showModal = true
        }) {
            Image(systemName: "gear").foregroundColor(.white)
                .position(x: geo.size.width * 0.92, y: geo.size.width * 0.03)
                .font(Font.system(size: 10 + geo.size.width * 0.03))
                .ignoresSafeArea()
                .padding(.top, 10)

        }.sheet(isPresented: $showModal) {
            SettingsView()
           }.accessibility(label:Text("Settings"))
    }
}


