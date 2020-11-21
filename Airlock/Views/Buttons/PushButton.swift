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
	@AppStorage(Settings.meditationTimerSeconds) var meditationTimerSeconds: Double = 120

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
		.accessibility(label: isOn ? Text("Cancel") : Text("Start 2 minutes meditation"))
		.contextMenu {
			if !isOn {
				Text("You can choose between:")
				Button("Standard: 2 minutes"){ meditationTimerSeconds = MeditationTime.twoMin.rawValue}
				Button("Medium: 20 minutes"){ meditationTimerSeconds = MeditationTime.twentyMin.rawValue }
				Button("Longer: 60 minutes!"){ meditationTimerSeconds = MeditationTime.oneHour.rawValue }
			}
		}
	}
}

enum MeditationTime: Double {
	case twoMin = 120
	case twentyMin = 1200
	case oneHour = 3600
}
