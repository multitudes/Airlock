//
//  DataSettings.swift
//  Airlock
//
//  Created by Laurent B on 20/01/2021.
//

import SwiftUI

struct DataSettings: View {
	@State private var showingResetConfirm = false
	@EnvironmentObject var dataController: DataController

    var body: some View {
		Section(header: Text("Data")){
			Button(action: {
				dataController.saveToFile()
			}, label: {
				Text("Backup Data")
			})
			Button("Delete All Data") {
				showingResetConfirm.toggle()
			}
			.accentColor(.red)
		}
		.disabled(dataController.itemCount() == 0)
		.alert(isPresented: $showingResetConfirm) {
			Alert(title: Text("Reset"), message: Text("Reset will delete all entries and it is irreversible"), primaryButton: .destructive(Text("Do It!"), action: reset), secondaryButton: .cancel())
		}
    }
	func reset() {
		dataController.objectWillChange.send()
		try? dataController.deleteAll()
	}
}

struct DataSettings___Previews: PreviewProvider {
    static var previews: some View {
        DataSettings()
    }
}
