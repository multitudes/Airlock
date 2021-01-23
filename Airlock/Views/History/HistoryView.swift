//
//  HistoryView.swift
//  anotherquickCoreDataTest
//
//  Created by Laurent B on 09/01/2021.
//

import CoreData
import SwiftUI

struct HistoryView: View {
	@EnvironmentObject var dataController: DataController
	@Environment(\.presentationMode) var presentationMode
	@State private var showingSaveConfirm = false
	@AppStorage("progressiveBackupInt") var progressiveBackupInt = 0

	let items: FetchRequest<Item>
	
	init() {
		UITableView.appearance().backgroundColor = .secondarySystemBackground
		let request: NSFetchRequest<Item> = Item.fetchRequest()
		request.sortDescriptors = [
			NSSortDescriptor(keyPath: \Item.creationDate, ascending: false)
		]
		items = FetchRequest(fetchRequest: request)
	}
	
	var body: some View {
		List {
			ForEach(items.wrappedValue) { item in
				Section(header: HistorySectionView(item: item)) {
					if !item.itemText.isEmpty {
						TextView(item: item)
					}
				}
				.textCase(nil)
			}
			.onDelete { offsets in
				for offset in offsets {
					let item = items.wrappedValue[offset]
					dataController.delete(item)
				}
				dataController.objectWillChange.send()
				dataController.save()
				
			}
		}
		.listStyle(InsetGroupedListStyle())
		.navigationBarTitle("History")
		
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {
					presentationMode.wrappedValue.dismiss()
				}, label: {
					Text("Done")
				})
			}
			ToolbarItem(placement: .navigationBarLeading) {
				Button(action: {
					saveTextToFile()
					showingSaveConfirm = true
				}, label: {
					Text("Save to Text")
				})
			}
		}
		.alert(isPresented: $showingSaveConfirm) {
			Alert(title: Text("Saved!"), message: Text("The History has been saved in your document folder. You can find it in the Files section of your ipad or connecting to a mac, it will be in the Finder window."), dismissButton: .default(Text("OK!")))
		}
	}
	var textFileURL: URL {
		progressiveBackupInt += 1
		let file = "myNotes-\(progressiveBackupInt).txt"
		return DataController.documentsFolder.appendingPathComponent(file)
	}
	func saveTextToFile() {
		var str = "This is your private list of annotations. Enjoy reading! :) \n"


		for item in items.wrappedValue {
			print(item.itemDate)
			str.append("\n*** \(item.itemDate) - " + "Time Meditated \(item.itemLength) min ***\n")
			if !item.itemText.isEmpty {
				str.append(item.itemText)
			}
		}

		do {
			print(str)
			try str.write(to: textFileURL, atomically: true, encoding: .utf8)
		} catch {
			print(error.localizedDescription)
		}

	}
}


struct HistoryView_Previews: PreviewProvider {
	static var dataController = DataController.preview
	static var previews: some View {
		HistoryView()
			.environment(\.managedObjectContext, dataController.container.viewContext)
			.environmentObject(dataController)
		
	}
}
