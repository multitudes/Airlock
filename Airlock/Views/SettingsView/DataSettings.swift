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
	@AppStorage("progressiveBackupInt") var progressiveBackupInt = 0

	var body: some View {
		Section(header: Text("Data")){
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

		let docFolder = DataController.documentsFolder
		do {
			let filePaths = try FileManager.default.contentsOfDirectory(at: docFolder, includingPropertiesForKeys: [])
			for filePath in filePaths {
				try FileManager.default.removeItem(at: filePath)
			}
			progressiveBackupInt = 0
			print("\nfolder cleared! \n")

		} catch {
			print("Could not clear temp folder: \(error)")
		}
	}
}

struct DataSettings___Previews: PreviewProvider {
	static var previews: some View {
		DataSettings()
	}
}
