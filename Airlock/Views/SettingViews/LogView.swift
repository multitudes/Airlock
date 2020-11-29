//
//  LogView.swift
//  Airlock
//
//  Created by Laurent B on 29/11/2020.
//

import SwiftUI

struct LogView: View {
	@FetchRequest(entity: LogItem.entity(), sortDescriptors: []) var myLogs: FetchedResults<LogItem>
	@Environment(\.managedObjectContext) var moc
@State var counter = 0
	var body: some View {
		VStack {
			List {
				ForEach(myLogs, id: \.id) { log in
					Text(log.text ?? "???" )
				}
			}
			Button("add \(myLogs.count)") {
				let meditations = ["monday","moon","quiet","aniccha"]
				let myMeditation = meditations.randomElement()!
				let logItem = LogItem(context: self.moc)
				logItem.id = UUID()
				logItem.text = myMeditation
				try? self.moc.save()
				print(logItem.debugDescription)
			}
		}
	}
}

struct LogView_Previews: PreviewProvider {
	static var previews: some View {
		LogView()
			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
