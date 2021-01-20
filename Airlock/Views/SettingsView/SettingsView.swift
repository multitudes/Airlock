//
//  SettingsView.swift
//  Airlock
//
//  Created by Laurent B on 28/08/2020.
//

import SwiftUI

struct SettingsView: View {
	@Environment(\.presentationMode) var presentationMode

	var isPhone: Bool {
		UIDevice.current.userInterfaceIdiom == .phone
	}
	
	init(){
		UITableView.appearance().backgroundColor = .secondarySystemBackground
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
			.navigationBarItems(trailing: Button("Done") {
				presentationMode.wrappedValue.dismiss()
			}
			.keyboardShortcut(.return, modifiers: [.command])
			)
		}
	}
}


struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}

