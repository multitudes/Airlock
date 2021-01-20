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
	@Environment(\.presentationMode) var presentationMode

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
					GeneralSettings()
					
					DataSettings()
					if isPhone {
						SettingSectionView()
					}
				}
				.textCase(nil)
				.font(.body)
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
	}
}


struct TabTwo_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}

