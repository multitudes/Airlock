//
//  AddTextView.swift
//  anotherquickCoreDataTest
///Users/laurentb/Developer
//  Created by Laurent B on 11/01/2021.
//

import SwiftUI

struct AddTextView: View {
	@AppStorage("addIsEnabled") var addIsEnabled2: Bool = false
	@AppStorage("lastMeditationDate") var lastMeditationDate: Date = Date()
	@Environment(\.presentationMode) var presentationMode
	//let item: Item
	@EnvironmentObject var dataController: DataController
	@Environment(\.managedObjectContext) var managedObjectContext
	@AppStorage("lastMeditationDuration") var lastMeditationDuration: Int = 120

	var date = Date()
	var length: Int16 = 0
	var characterLimit = 280 // two tweets!

	@State private var inputText = "This is some editable text..." {
		didSet {
			if inputText.count > characterLimit {
				inputText = String(inputText.prefix(characterLimit))
			}
		}
	}

	@State private var letterCount = 0
	@State private var lineCount = 0

	var HeaderTextView : some View {
		Text("Add your thoughts about today's meditation:")
	}

	var FooterTextView: some View {
		VStack(alignment: .leading) {
			Text("\(characterLimit - letterCount)")
				.foregroundColor(letterCount > 280 ? .red : .secondary)
			Text("Exceeds max lines")
				.foregroundColor(lineCount > 14 ? .red : .clear)
		}
	}
	var placeholder = "This is some editable text..."

	var body: some View {
		VStack {
			Form {
				Section(header: HeaderTextView, footer: FooterTextView) {
					TextEditor(text: $inputText)
						.font(.custom("HelveticaNeue", size: 13))
						.foregroundColor(self.inputText == placeholder ? .gray : .primary)
						.frame(height: 230, alignment: .leading)
						.lineLimit(3)
						.onTapGesture {
							if self.inputText == "This is some editable text..." {
								self.inputText = ""
							}
						}
						.onChange(of: inputText){ value in
							letterCount = inputText.count
							lineCount = inputText.lines.count
						}
				}
				.textCase(nil)
			}
			.allowsTightening(true)
			.cornerRadius(10)

		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button {
					lastMeditationDate = Date().addingTimeInterval(-1000000)
					try? dataController.addItem(with: inputText, duration: Int16(lastMeditationDuration))
					dataController.objectWillChange.send()
					presentationMode.wrappedValue.dismiss()
				} label: {
					Text("Add")
				}
				.disabled(letterCount > 280 || lineCount > 14 || inputText == placeholder || inputText.count == 0)
			}
			ToolbarItem(placement: .navigationBarLeading) {
				Button {
					presentationMode.wrappedValue.dismiss()
				} label: {
					Text("Cancel")
				}
			}
		}
		.background(Color.systemGroupedBackground).ignoresSafeArea()
		.navigationTitle("Write something")
	}
}

struct AddTextView_Previews: PreviewProvider {
	static var previews: some View {
		AddTextView()
	}
}

public extension String {
	var lines: [String] {
		components(separatedBy: .newlines)
	}
}
