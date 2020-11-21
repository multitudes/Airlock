//
//  MainView.swift
//  Airlock
//
//  Created by Laurent B on 28/08/2020.
//
import AVFoundation
import SwiftUI

extension UIDevice {
	static func vibrate() {
		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
	}
}

struct MainView: View {
	@AppStorage("vibrateIsOn") var vibrateIsOn: Bool = false

	@State var progress: CGFloat = 0.0
	@State var isOn: Bool = false
	@State var showPopup = false
	@State var dismissCount: Int = 4
	@State var showModal: Bool = false

	//#warning("After testing reset to 120")
	var meditationTimerSeconds: CGFloat = 120
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				BackgroundGradient()

				SettingsButton(showModal: $showModal)
					.position(x: geometry.size.width * 0.92, y: geometry.size.width * 0.03)
					.font(Font.system(size: 10 + geometry.size.width * 0.03))
					.padding(.top, 10)

				if isOn {
					let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
					Text("")
						.onReceive(timer) { _ in
							if progress < meditationTimerSeconds {
								progress += 0.01

							} else {
								isOn = false
								timer.upstream.connect().cancel()
								// present pop over
								withAnimation(Animation.easeInOut(duration: 0.3)) {
									showPopup = true
								}
								if vibrateIsOn == false {
									playSound(sound: "gong.m4a")
								} else {
									UIDevice.vibrate()
									print("vibrating!")
								}
							}
						}.frame(minWidth: geometry.size.width, alignment: .center)
				}

				TitleView(isOn: isOn, width: geometry.size.width, height: geometry.size.height)

				ActivityRingView(timerIsOn: $isOn, progress: $progress, frameSize: geometry.size.width / 1.4 )
					.fixedSize()
					.position(x: geometry.size.width / 2 , y: geometry.size.height / 2)

				demoCloudsAnimation(change: $isOn, screenWidth: geometry.size.width, delay: .constant(2) )
				demoCloudsAnimation(change: $isOn, screenWidth: geometry.size.width, delay: .constant(6))
				demoCloudsAnimation(change: $isOn, screenWidth: geometry.size.width, delay: .constant(30))

				PushButton(isOn: $isOn, progress: $progress, size: geometry.size.width)
					.position(x: geometry.size.width / 2 , y: isOn ? geometry.size.height / 2 : geometry.size.height / 2 + geometry.size.height / 2.5)

				if showPopup {
					let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
					ZStack {
						OpaqueOverlayView()
							.onTapGesture {
								reset()
							}
						EndPopUpView(dismissCount: dismissCount, width: geometry.size.width)

					}
					.onReceive(timer) { _ in
						if dismissCount > 0 {
							dismissCount -= 1
						} else {
							timer.upstream.connect().cancel()
							reset()
						}
					}
				}
			}
		}
	}
	private func reset() {
		AppReviewRequest.requestReviewIfNeeded()
		isOn = false
		withAnimation(Animation.easeOut(duration: 1.2)){
			showPopup = false
		}
		progress = 0.0
		dismissCount = 4
		stopSound()
	}
}



struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
			.preferredColorScheme(.light)
	}
}
struct MainView_Previews_dark: PreviewProvider {
	static var previews: some View {
		MainView()
			.preferredColorScheme(.dark)
	}
}
