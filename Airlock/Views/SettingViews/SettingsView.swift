//
//  SettingsView.swift
//  Airlock
//
//  Created by Laurent B on 28/08/2020.
//

import UIKit
import SwiftUI
import AVFoundation
import MessageUI

struct ActivityViewController: UIViewControllerRepresentable {
	typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
	var activityItems: [Any] = [URL(string: "https://www.apple.com")!]
	var applicationActivities: [UIActivity]? = nil
	let excludedActivityTypes: [UIActivity.ActivityType]? = nil
	let callback: Callback? = nil
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
		let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
		controller.excludedActivityTypes = excludedActivityTypes
		controller.completionWithItemsHandler = callback
		return controller
	}
	
	func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
	
}

struct SettingsView: View {
	@EnvironmentObject var dataController: DataController

	@AppStorage("vibrateIsOn") var vibrateIsOn: Bool = false
	@Environment(\.presentationMode) var presentationMode
	
	@State var toggleIsOn: Bool = false
	@State var result: Result<MFMailComposeResult, Error>? = nil
	@State var isShowingMailView = false
	@State private var isRecommendAppPresented: Bool = false
	@State var alertNoMail = false

	let myAppStoreURL = "https://apps.apple.com/us/app/two-minutes-meditation/id1530067435"
	
	var isPhone: Bool {
		UIDevice.current.userInterfaceIdiom == .phone
	}
	
	init(){
		UITableView.appearance().backgroundColor = .clear
	}
	
	var body: some View {
		NavigationView {
			ZStack{
				BackgroundGradient().opacity(0.2)
				Form {
					Section(header: Text("General"), footer: isPhone ? AnyView(Text("")) :
								AnyView(Text("©Laurent Brusa v1.0 2020")
											.accessibility(label: Text("©Laurent Brusa")))
					) {
						NavigationLink(destination: AboutThisApp()) {
							HStack {
								Image(systemName: "info.circle").padding(5)
								Text("About This App")
							}
							.accessibilityElement(children: .ignore)
							.accessibility(label: Text("AboutThisApp"))
						}
						
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
						
						
						NavigationLink(destination: PrivacyView()) {
							HStack {
								Image(systemName: "doc.text.magnifyingglass").padding(5)
								Text("Privacy")
							}
						}
						.accessibilityElement(children: .ignore)
						.accessibility(label: Text("Data Privacy"))

						NavigationLink(destination: HistoryView()) {
							HStack {
								Image(systemName: "list.bullet.rectangle").padding(5)
								Text("Logs")
							}
						}
						.accessibilityElement(children: .ignore)
						.accessibility(label: Text("Logs"))
					}
					.listRowBackground(BackgroundGradient().opacity(0.2))
					
					if isPhone {
						Section(header: Text("Settings"), footer:
									Text("© Laurent Brusa v1.0 2020")
									.bold()
									.accessibility(label: Text("©Laurent Brusa")))
						{
							Toggle(isOn: $vibrateIsOn,
								   label: {
									HStack {
										Image(systemName: "speaker.slash").padding(5)
											.accessibility(hidden: true)
										Text("Vibrate Only")
									}
								   })
							
						}
						.listRowBackground(BackgroundGradient().opacity(0.2))
					}
				}.font(.body)
				
			}
			.navigationBarTitle("Settings")
			.navigationBarItems(trailing:
									Button("Done") {
										presentationMode.wrappedValue.dismiss()
									}
									.keyboardShortcut(.escape, modifiers: [])
			)
		}.accentColor(.primary)
		.foregroundColor(.primary)
	}
}


struct TabTwo_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}

