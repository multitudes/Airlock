//
//  PushButton.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

@discardableResult
func log(_ message: String, _ file: String = #file, _ line:Int = #line, _ function: String = #function) -> String {
	let logMessage = "[\(file):\(line)] \(function) - \(message)"
	print(logMessage)
	return logMessage
}

struct PushButton: View {
	@Binding var isOn: Bool
	@Binding var progress: Double

	let title: String = "Start"
	var size: CGFloat
	var onColors = [Color.gradientStartRed, Color.buttonLightRed]

	var body: some View {
		Button(action: {
			isOn.toggle()
			if !isOn { progress = 0.0 }
		}, label: {
			Text(isOn ? "Cancel" : "  Start  ") // the whitespaces in "Start" are there to avoid animation irregularities
		})
		.padding()
		.font(.system(size: 44, weight: .bold, design: .rounded))
		.foregroundColor(.white)
		.contentShape(RoundedRectangle(cornerRadius: 20))
		.animation(.easeOut(duration: 0.8))
		.keyboardShortcut(.space, modifiers: [])
		.accessibility(label: isOn ? Text("Cancel") : Text("Start meditation"))
	}
}

enum MeditationTime: Double {
	case twoMin = 120
	case twentyMin = 1200
	case oneHour = 3600
}
