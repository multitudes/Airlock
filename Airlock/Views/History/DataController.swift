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

	func addItem(with text: String, duration: Int16) throws {
		let viewContext = container.viewContext
		let item = Item(context: viewContext)
		item.creationDate = Date()
		item.timeMeditated = duration
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

	private static var documentsFolder: URL {
		do {
			return try FileManager.default.url(for: .documentDirectory,
										in: .userDomainMask,
										appropriateFor: nil,
										create: false)
		} catch {
			fatalError("Can't find documents directory.")
		}
	}

	private static var fileURL: URL {
		return documentsFolder.appendingPathComponent("personalNotes.data")
	}

//	func load() {
//		DispatchQueue.global(qos: .background).async { [weak self] in
//			guard let data = try? Data(contentsOf: Self.fileURL) else {return}
//
//			guard let items  = try? JSONDecoder().decode([Item].self, from: data) else {
//			fatalError()
//		}
//		DispatchQueue.main.async {
//			self?.items = items
//		}
//	   }
//	}

	func saveToFile() {
		let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
		fetchRequest.sortDescriptors = [
			NSSortDescriptor(keyPath: \Item.creationDate, ascending: false)
		]
		let fetchedItems = FetchRequest(fetchRequest: fetchRequest)
		var items: [Item] = []
		for item in fetchedItems.wrappedValue {
			items.append(item)
		}
		DispatchQueue.global(qos: .background).async {
			guard let data = try? JSONEncoder().encode(items) else { fatalError()}
			print(Self.fileURL)

			do {
				let outfile = Self.fileURL
				try data.write(to: outfile)
				print(Self.fileURL)
			} catch {
				fatalError()
			}

		}

	}
}


