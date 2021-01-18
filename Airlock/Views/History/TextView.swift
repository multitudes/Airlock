//
//  TextView.swift
//  anotherquickCoreDataTest
//
//  Created by Laurent B on 10/01/2021.
//

import CoreData
import SwiftUI

struct TextView: View {
	@EnvironmentObject var dataController: DataController
	@ObservedObject var item: Item
	
	var body: some View {
		NavigationLink(item.itemText, destination: DisplayItemView(item: item))
			.lineLimit(1)
			.font(.body)
	}
}

struct TextView_Previews: PreviewProvider {
	
	static var previews: some View {
		TextView(item: Item.example)
	}
}
