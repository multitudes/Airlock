//
//  NoteButton.swift
//  Airlock
//
//  Created by Laurent B on 18/01/2021.
//

import SwiftUI

struct NoteButton: View {

	@Environment(\.managedObjectContext) var managedObjectContext
	@State var showNote: Bool = false
	@AppStorage("lastMeditationDate") var lastMeditationDate: Date = Date().addingTimeInterval(-100000)
	
	var addIsEnabled: Bool {
		Calendar.current.isDateInToday(lastMeditationDate)
	}

	var body: some View {
		Button(action: {
			self.showNote = true
		}) {
				Image(systemName: "pencil.tip.crop.circle.badge.plus")
			}
		.disabled(!addIsEnabled)
		.padding(5)
		.clipShape(Circle())
		.foregroundColor(.white).opacity(addIsEnabled ? 1 : 0.5)
		.sheet(isPresented: $showNote) {
			NavigationView {
				AddTextView()
					.environment(\.managedObjectContext, self.managedObjectContext)
			}
		}
		.accessibility(label:Text("write a note"))
		.keyboardShortcut("n", modifiers: [.command])

	}
}

struct NoteButton_Previews: PreviewProvider {
	static var previews: some View {
		NoteButton()
			.background(Color.red)
	}
}
