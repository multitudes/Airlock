//
//  HistoryButton.swift
//  
//
//  Created by Laurent B on 18/01/2021.
//

import CoreData
import SwiftUI

struct HistoryButton: View {
	@EnvironmentObject var dataController: DataController
	@Environment(\.managedObjectContext) var managedObjectContext
	@Binding var isPresentingHistoryView: Bool
	
	var body: some View {
		Button(action: {
			self.isPresentingHistoryView = true
		}) {
			Image(systemName: "doc.plaintext.fill").foregroundColor(.white)
		}
		.fullScreenCover(isPresented: $isPresentingHistoryView) {
			NavigationView {
				HistoryView()
					.environmentObject(dataController)
					.environment(\.managedObjectContext, self.managedObjectContext)
			}
		}
		.accessibility(label:Text("Show my history"))
		.keyboardShortcut("h", modifiers: [.command])
	}
}

struct HistoryButton_Previews: PreviewProvider {
	static var previews: some View {
		HistoryButton(isPresentingHistoryView: .constant(true))
	}
}
