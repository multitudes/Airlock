//
//  GeneralSettings.swift
//  Airlock
//
//  Created by Laurent B on 20/01/2021.
//

import SwiftUI

struct GeneralSettings: View {
	@State private var isRecommendAppPresented: Bool = false
		
	var isPhone: Bool {
		UIDevice.current.userInterfaceIdiom == .phone
	}
	
	let myAppStoreURL = "https://apps.apple.com/us/app/two-minutes-meditation/id1530067435"
	
	var body: some View {
		Section(header: Text("General")) {
			NavigationLink(destination: AboutThisApp()) {
				Label("About This App", systemImage: "info.circle")
			}
			
			NavigationLink(destination: PrivacyView()) {
				Label("Privacy", systemImage: "doc.text.magnifyingglass")
			}
			
			Button(action: {
				self.isRecommendAppPresented = true
			}, label: {
				Label("Recommend App", systemImage: "hand.thumbsup")
					.sheet(isPresented: $isRecommendAppPresented) {
						ActivityViewController(activityItems: [URL(string: myAppStoreURL)!])
					}
			})
			
			Link(destination: URL(string: "https://testflight.apple.com/join/rfPbYjXH")!) {
				Label("Rate App", systemImage: "star")
			}

			ShowingMailView()

		}
	}
}

struct GeneralSettings_Previews: PreviewProvider {
	static var previews: some View {
		GeneralSettings()
	}
}
