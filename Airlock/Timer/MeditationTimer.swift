//
//  MeditationTimer.swift
//  Airlock
//
//  Created by Laurent B on 21/01/2021.
//

import Foundation

class MeditationTimer: ObservableObject {

	var lengthInMinutes: Int
	private var frequency: TimeInterval { 1.0 / 60.0 }
	private var lengthInSeconds: Int { lengthInMinutes * 60 }
	private var timer: Timer?
	private var timerStopped = false

	@Published var secondsElapsed = 0
	@Published var secondsRemaining = 0
	@Published var progress: Double = 0.0

	init(lengthInMinutes: Int = 0) {
		self.lengthInMinutes = lengthInMinutes
		secondsRemaining = lengthInSeconds
	}

	func startTimer() {
		
		}

	func stopTimer() {
		timer?.invalidate()
		timer = nil
		timerStopped = true
	}
}
