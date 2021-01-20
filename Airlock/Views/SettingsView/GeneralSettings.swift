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
				HStack {
					Image(systemName: "info.circle").padding(5)
					Text("About This App")
				}
				.accessibilityElement(children: .ignore)
				.accessibility(label: Text("AboutThisApp"))
			}

			NavigationLink(destination: PrivacyView()) {
				HStack {
					Image(systemName: "doc.text.magnifyingglass").padding(5)
					Text("Privacy")
				}
			}
			.accessibilityElement(children: .ignore)
			.accessibility(label: Text("Data Privacy"))

			Button(action: {
				self.isRecommendAppPresented = true
			}, label: {
				HStack {
					Image(systemName: "hand.thumbsup").padding(5)
					Text("Recommend App")
				}
				.accessibilityElement(children: .ignore)
				.accessibility(label: Text("Recommend this App"))
				.sheet(isPresented: $isRecommendAppPresented) {
					ActivityViewController(activityItems: [URL(string: myAppStoreURL)!])
				}
			})

			Link(destination: URL(string: "https://testflight.apple.com/join/rfPbYjXH")!) {
				HStack {
					Image(systemName: "star").padding(5)
					Text("Rate App")
				}
				.accessibilityElement(children: .ignore)
				.accessibility(label: Text("Rate this App"))
			}

			Button(action: {
				isShowingMailView = true
			}) {
				HStack {
					Image(systemName: "bubble.left").padding(5)
					Text("Feedback")
				}.onTapGesture {
					MFMailComposeViewController.canSendMail() ? self.isShowingMailView.toggle() : self.alertNoMail.toggle()
				}
				.accessibilityElement(children: .ignore)
				.accessibility(label: Text("Send a feedback per email"))
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
