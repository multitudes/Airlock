//
//  HistorySectionView.swift
//  anotherquickCoreDataTest
//
//  Created by Laurent B on 11/01/2021.
//

import SwiftUI

struct HistorySectionView: View {
	@EnvironmentObject var dataController: DataController
	@ObservedObject var item: Item

	var body: some View {
		HStack {
			Text("\(item.itemDate)")
			Spacer()
			Label("\(item.itemLength) min", systemImage: "clock")
				.font(.caption)
				.accessibilityLabel(Text("minutes"))
				.accessibilityValue(Text("\(item.itemLength)"))
		}
	}
}

struct HistorySectionView_Previews: PreviewProvider {
	static var previews: some View {
		HistorySectionView(item: Item.example)
	}
}
