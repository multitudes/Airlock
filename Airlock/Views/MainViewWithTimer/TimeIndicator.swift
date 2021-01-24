//
//  TimeIndicator.swift
//  Airlock
//
//  Created by Laurent B on 25/11/2020.
//

import SwiftUI

struct TimeIndicator: View {
	@AppStorage(Settings.meditationTimerSeconds) var meditationTimerSeconds: Double = 120

	var isOn: Bool
	var time: String {
		switch meditationTimerSeconds {
			case MeditationTime.twoMin.rawValue:
				return "2"
			case MeditationTime.twentyMin.rawValue:
				return "20"
			case MeditationTime.oneHour.rawValue:
				return "60"
			default:
				return ""
		}
	}
    var body: some View {
        Text(time)
			.foregroundColor(.white)
			.contextMenu {
				if !isOn {
					Text("You can choose between:")
					Button("Standard: 2 minutes"){ meditationTimerSeconds = MeditationTime.twoMin.rawValue}
					Button("Medium: 20 minutes"){ meditationTimerSeconds = MeditationTime.twentyMin.rawValue }
					Button("Longer: 1 hour"){ meditationTimerSeconds = MeditationTime.oneHour.rawValue }
				}
			}
    }
}

struct TimeIndicator_Previews: PreviewProvider {
    static var previews: some View {
		TimeIndicator(meditationTimerSeconds: 1200, isOn: false)
			.previewLayout(.fixed(width: 200.0, height: 100))
			.preferredColorScheme(.dark)
			.environment(\.sizeCategory, .medium)
		TimeIndicator(meditationTimerSeconds: 3600, isOn: false)
			.frame(width: 200.0, height: 0.0)
			.previewLayout(.fixed(width: 200.0, height: 100.0))
			.preferredColorScheme(.dark)
			.environment(\.sizeCategory, .medium)
			.frame(width: 200.0, height: 0.0)

    }
}
