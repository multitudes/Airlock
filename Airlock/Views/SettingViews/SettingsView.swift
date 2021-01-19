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
	@State private var showingResetConfirm = false
	
	let myAppStoreURL = "https://apps.apple.com/us/app/two-minutes-meditation/id1530067435"
	
	var isPhone: Bool {
		UIDevice.current.userInterfaceIdiom == .phone
	}
	
	init(){
		UITableView.appearance().backgroundColor = .secondarySystemBackground
		//UITableView.appearance().backgroundColor = .clear
	}
	
	var body: some View {
		NavigationView {
			Form {
				List {
					Section(header: Text("General"), footer: isPhone ? AnyView(Text("")) :
								AnyView(Text("© Laurent Brusa v1.0 2021")
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
					.textCase(nil)
					.font(.body)
					
					Section(header: Text("Data")){
						Button(action: {}, label: {
							Text("Export Data to CSV")
						}).disabled(true)
						Button("Delete All Data") {
							showingResetConfirm.toggle()
						}
						.disabled(dataController.itemCount() == 0)
						.accentColor(.red)
					}
					.textCase(nil)
					.font(.body)
					
					if isPhone {
						Section(header: Text("Settings"), footer:
									Text("© Laurent Brusa v1.0 2021").padding(.vertical)
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
						.textCase(nil)
						.font(.body)
					}
				}
			}
			.listStyle(InsetGroupedListStyle())
			.background(Color.systemGroupedBackground)
			.navigationBarTitle("Settings")
			.navigationBarItems(trailing:
									Button("Done") {
										presentationMode.wrappedValue.dismiss()
									}
									.keyboardShortcut(.return, modifiers: [.command])
			)
		}
		.alert(isPresented: $showingResetConfirm) {
			Alert(title: Text("Reset"), message: Text("Reset will delete all entries and it is irreversible"), primaryButton: .destructive(Text("Do It!"), action: reset), secondaryButton: .cancel())
		}
	}
	func reset() {
		dataController.objectWillChange.send()
		try? dataController.deleteAll()
		//presentationMode.wrappedValue.dismiss()
	}
}


struct TabTwo_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}

