//
//  GeneralSettings.swift
//  Airlock
//
//  Created by Laurent B on 20/01/2021.
//

import MessageUI
import SwiftUI

struct GeneralSettings: View {
	@State var isShowingMailView = false
	@State private var isRecommendAppPresented: Bool = false
	@State var alertNoMail = false
	@State var result: Result<MFMailComposeResult, Error>? = nil
	
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
			
			Button(action: {
				isShowingMailView = true
			}) {
				Label("Send Feedback", systemImage: "bubble.left")
					.onTapGesture {
						MFMailComposeViewController.canSendMail() ? self.isShowingMailView.toggle() : self.alertNoMail.toggle()
					}
					.sheet(isPresented: $isShowingMailView) {
						MailView(result: self.$result)
					}
					.alert(isPresented: self.$alertNoMail) {
						Alert(title: Text("Please set up your email account on your Apple device to send a feedback"))
					}
			}
		}
	}
}

struct GeneralSettings_Previews: PreviewProvider {
	static var previews: some View {
		GeneralSettings()
	}
}
