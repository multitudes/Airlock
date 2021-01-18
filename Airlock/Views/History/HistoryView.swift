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
	let items: FetchRequest<Item>
	
	@State private var showingResetConfirm = false
	
	init() {
		UITableView.appearance().backgroundColor = .secondarySystemBackground
		let request: NSFetchRequest<Item> = Item.fetchRequest()
		request.sortDescriptors = [
			NSSortDescriptor(keyPath: \Item.creationDate, ascending: false)
		]
		request.fetchLimit = 10
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
//				ToolbarItem(placement: .navigationBarTrailing) {
//					Button(action: {
//						showingResetConfirm = true
//					}, label: {
//						Text("Reset")
//					})
//					.disabled(items.wrappedValue.isEmpty)}

				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: {
						presentationMode.wrappedValue.dismiss()
					}, label: {
						Text("Done")
					})
				}
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


struct HistoryView_Previews: PreviewProvider {
	static var dataController = DataController.preview
	static var previews: some View {
		HistoryView()
			.environment(\.managedObjectContext, dataController.container.viewContext)
			.environmentObject(dataController)
		
	}
}
