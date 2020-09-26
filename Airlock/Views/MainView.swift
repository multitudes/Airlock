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
    @EnvironmentObject var settings: UserSettings
    
    @State var progress: CGFloat = 0.0
    @State var isOn: Bool = false
    @State private var showPopup = false
    @State var dismissCount: Int = 4
    @State var showModal: Bool = false
    
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
                            if progress < 120 {
                                progress += 0.01
                                
                            } else {
                                isOn = false
                                // present pop over
                                withAnimation(Animation.easeInOut(duration: 0.3)) {
                                    showPopup = true
                                }
                                if settings.vibrate == false {
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
                PushButton(isOn: $isOn, progress: $progress, size: geometry.size.width)
                    .position(x: geometry.size.width / 2 , y: isOn ? geometry.size.height / 2 : geometry.size.height / 2 + geometry.size.height / 2.5)
                
                
                    demoCloudsAnimation(change: $isOn, screenWidth: geometry.size.width, delay: .constant(2) )
                    demoCloudsAnimation(change: $isOn, screenWidth: geometry.size.width, delay: .constant(6))
                    demoCloudsAnimation(change: $isOn, screenWidth: geometry.size.width, delay: .constant(30))
            
                
                if showPopup {
                    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    ZStack {
                        Color.black
                            .opacity(0.7)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                reset()
                            }
                        VStack(spacing: 20) {
                            Spacer(minLength: 2.0)
                            Text("Done!")
                                .font(.largeTitle).bold()
                            Spacer(minLength: 4.0)
                            Text("Dismissing in :")
                            Text("\(dismissCount)")
                            Spacer(minLength: 2.0)
                                
                                .onReceive(timer) { _ in
                                    if dismissCount > 0 {
                                        dismissCount -= 1
                                    } else {
                                        reset()
                                        stopSound()
                                    }
                                }
                        }.frame(width: geometry.size.width / 1.2, height: geometry.size.width / 1.2)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 10)
                                .frame(width: geometry.size.width / 1.2 - 50, height: geometry.size.width / 1.2 - 50))
                        .background(RoundedRectangle(cornerRadius: 20)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.gradientStartRed, Color.gradientEndRed]), startPoint: .top, endPoint: .bottom)))
                    }
                }
            }
        }
    }
    private func reset() {
        isOn = false
        progress = 0.0
        withAnimation(Animation.easeOut(duration: 0.2)) {
            showPopup = false
        }
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
