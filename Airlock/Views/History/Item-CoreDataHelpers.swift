//
//  Item-CoreDataHelpers.swift
//  anotherquickCoreDataTest
//
//  Created by Laurent B on 09/01/2021.
//

import Foundation
import SwiftUI

extension Item {
	var itemText: String {
		myText ?? ""
	}
	var itemLength: Int {
		Int(timeMeditated)
	}

	var itemDate: String {
		let date = creationDate ?? Date()
		let formatter = DateFormatter()
		formatter.locale = .autoupdatingCurrent
		//		formatter.locale = Locale(identifier: "ja_JP@calendar=japanese")
		//formatter.timeZone = TimeZone(secondsFromGMT: timezone)
		formatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d, h:mm a")
		let dateString = formatter.string(from: date)
		return dateString
	}

	static var example: Item {
		let controller = DataController(inMemory: true)
		let viewContext = controller.container.viewContext
		let item = Item(context: viewContext)
		item.myText = "Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, Example Item, "
		item.creationDate = Date()
		item.timeMeditated = 20
		return item
	}

}

extension Date {
	static var currentYear: Int {
		return Calendar.current.component(.year, from: Date())
	}
}

extension Color {
	static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
	static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
}
