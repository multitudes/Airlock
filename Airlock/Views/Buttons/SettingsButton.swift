//
//  SettingsButton.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

struct SettingsButton: View {
	@EnvironmentObject var dataController: DataController
	@Binding var showModal: Bool

	var body: some View {
		Button(action: {
			self.showModal = true
		}) {
			Image(systemName: "gear").foregroundColor(.white)
		}.sheet(isPresented: $showModal) {
			SettingsView()
				.environmentObject(dataController)
		}
		.accessibility(label:Text("Settings"))
		.keyboardShortcut(",", modifiers: [.command])
	}
}


struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(showModal: .constant(true))
        
    }
}
