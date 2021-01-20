//
//  SettingSectionView.swift
//  Airlock
//
//  Created by Laurent B on 20/01/2021.
//

import SwiftUI

struct SettingSectionView: View {
	@AppStorage("vibrateIsOn") var vibrateIsOn: Bool = false
	
	var body: some View {
		Section(header: Text("Settings"), footer:
					Text("© Laurent Brusa v1.0 2021").padding(.vertical)
					.accessibility(label: Text("©Laurent Brusa"))) {
			Toggle(isOn: $vibrateIsOn) {
					Label("Vibrate Only", systemImage: "speaker.slash")
				   }
		}
	}
}

struct SettingSectionView_Previews: PreviewProvider {
	static var previews: some View {
		SettingSectionView()
	}
}
