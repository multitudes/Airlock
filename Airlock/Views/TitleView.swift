//
//  TitleView.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

struct TitleView: View {
	@AppStorage(Settings.meditationTimerSeconds) var meditationTimerSeconds: Double = 120

	var isOn: Bool
    var width: CGFloat
    var height: CGFloat
	let observeYourBreath: String = "Observe Your Breath"
	var title: String {
		switch meditationTimerSeconds {
			case MeditationTime.twoMin.rawValue:
				return "Two Minutes Meditation"
			case MeditationTime.twentyMin.rawValue:
				return "Twenty Minutes Meditation"
			case MeditationTime.oneHour.rawValue:
				return "One Hour Meditation"
			default:
				return ""
		}
	}
    
    var body: some View {
        Text(isOn ? observeYourBreath : title)
			.font(.system(size: 33 + width / 40, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .bold()
            .padding(.horizontal)
			.contentShape(RoundedRectangle(cornerRadius: 20))
			.contextMenu {
				if !isOn {
					Text("You can choose between:")
					Button("Standard: 2 minutes"){ meditationTimerSeconds = MeditationTime.twoMin.rawValue}
					Button("Medium: 20 minutes"){ meditationTimerSeconds = MeditationTime.twentyMin.rawValue }
					Button("Longer: 1 hour"){ meditationTimerSeconds = MeditationTime.oneHour.rawValue }
				}
			}
            .position(x: width / 2 , y: height / 8)
            .frame(minWidth: width * 0.9, alignment: .center)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .animation(.easeIn)
    }
}

