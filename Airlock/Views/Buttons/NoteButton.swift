//
//  NoteButton.swift
//  Airlock
//
//  Created by Laurent B on 18/01/2021.
//

import SwiftUI

struct NoteButton: View {
	@Binding var showNote: Bool

	var body: some View {

			Button(action: {
				self.showNote = true
			}) {
				Image(systemName: "pencil.tip.crop.circle.badge.plus").foregroundColor(.white)
			}.sheet(isPresented: $showNote) {
				NavigationView {
				AddTextView()
				}
			}
			.accessibility(label:Text("write a note"))
			.keyboardShortcut("n", modifiers: [.command])

	}
}

struct NoteButton_Previews: PreviewProvider {
	static var previews: some View {
		NoteButton(showNote: .constant(true))
			.background(Color.red)
	}
}
