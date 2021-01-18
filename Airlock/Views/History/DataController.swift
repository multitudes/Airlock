//
//  DataController.swift
//  anotherquickCoreDataTest
//
//  Created by Laurent B on 09/01/2021.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
	let container: NSPersistentCloudKitContainer

	func itemCount() -> Int {
		let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
		return (try? container.viewContext.count(for: fetchRequest)) ?? 0
	}
	
	init(inMemory: Bool = false) {
		container = NSPersistentCloudKitContainer(name: "Main")
		if inMemory {
			container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
		}
		container.loadPersistentStores { storeDescription, error in
			if let error = error {
				fatalError("Fatal error loading store: \(error.localizedDescription)")
			}
		}
	}

	func addItem(with text: String) throws {
		let viewContext = container.viewContext
		let item = Item(context: viewContext)
		item.creationDate = Date()
		item.timeMeditated = 0
		item.myText = text
		try viewContext.save()
	}

	func createSampleData() throws {
		let viewContext = container.viewContext
		let item = Item(context: viewContext)
		item.creationDate = Date()
		item.timeMeditated = 2
		item.myText = "Hello Core Data"
		let item2 = Item(context: viewContext)
		item2.timeMeditated = 20
		item2.creationDate = Date()
		//item2.myText = "Hello Core Data2"
		let item3 = Item(context: viewContext)
		item3.timeMeditated = 60
		item3.creationDate = Date()
		item3.myText = "Hello Core Data, Hello Core Data, Hello Core Data, Hello Core Data, Hello Core Data, Hello Core Data, Hello Core Data, Hello Core Data, Hello Core Data, Hello Core Data"
		try viewContext.save()
	}

	static var preview: DataController = {
		let dataController = DataController(inMemory: true)
		let viewContext = dataController.container.viewContext
		do {
			try dataController.createSampleData()
		} catch {
			fatalError()
		}
		return dataController
	}()

	func save() {
		if container.viewContext.hasChanges {
			try? container.viewContext.save()
		}
	}

	func delete(_ object: NSManagedObject) {
		container.viewContext.delete(object)
	}

	func deleteAll() throws {

		let viewContext = container.viewContext

		let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
		let batchdeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

		_ = try? container.viewContext.execute(batchdeleteRequest)
		try viewContext.save()
	}

	
}
