//
//  DisplayItemView.swift
//  anotherquickCoreDataTest
//
//  Created by Laurent B on 13/01/2021.
//

import SwiftUI

struct DisplayItemView: View {
	@ObservedObject var item: Item

	var body: some View {
		List {
			Section(header: HistorySectionView(item: item)) {
				Text(item.itemText)
					.font(.body)
			}
		}
		.background(Color.secondarySystemGroupedBackground)
		.cornerRadius(10)
		.shadow(color: Color.black.opacity(0.2), radius: 5)
		.listStyle(InsetGroupedListStyle())
		.ignoresSafeArea()
	}
}

struct DisplayItemView_Previews: PreviewProvider {
	static var previews: some View {
		DisplayItemView(item: Item.example)
	}
}
