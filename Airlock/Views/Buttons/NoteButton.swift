//
//  NoteButton.swift
//  Airlock
//
//  Created by Laurent B on 18/01/2021.
//

import SwiftUI

struct NoteButton: View {
	@State private var animation = 0.0

	@Environment(\.managedObjectContext) var managedObjectContext
	@Binding var showNote: Bool
	@AppStorage("lastMeditationDate") var lastMeditationDate: Date = Date().addingTimeInterval(-100000)

	var addIsEnabled: Bool {
		Calendar.current.isDateInToday(lastMeditationDate)
	}

	var body: some View {
		if addIsEnabled {
		Button(action: {
			self.showNote = true
		}) {
				Image(systemName: "pencil.tip.crop.circle.badge.plus").foregroundColor(.white)
			}
		.padding(5)
		.clipShape(Circle())
		.foregroundColor(.white)
		.overlay(
			Circle()
				.stroke(Color.white, lineWidth: 1.5)
				.scaleEffect(CGFloat(1.2+animation))
				.opacity(0.8-animation)
		)
		.onAppear {
			withAnimation(Animation.easeOut(duration: 8).repeatForever(autoreverses: false)) {
				animation = 1
			}
		}

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
}

struct NoteButton_Previews: PreviewProvider {
	static var previews: some View {
		NoteButton(showNote: .constant(true))
			.background(Color.red)
	}
}
