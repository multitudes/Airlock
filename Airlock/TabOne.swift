//
//  TabOne.swift
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

struct TabOne: View {
    @EnvironmentObject var settings: UserSettings
    @State var progress: CGFloat = 0.0
    @State var isOn: Bool = false
    @State private var showPopup = false
    @State var dismissCount: CGFloat = 5.0
    @State var showModal: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            GeometryReader { geometry in
                Button(action: {
                    print("Button Pushed")
                    self.showModal = true
                }) {
                    Image(systemName: "gear")
                        .position(x: geometry.size.width * 0.92, y: geometry.size.width * 0.03)
                        .foregroundColor(.white)
                        .font(Font.system(size: 10 + geometry.size.width * 0.03)).ignoresSafeArea().padding(.top, 5)
                    
                }.sheet(isPresented: $showModal) {
                    TabTwo()
                   }
                
                
                if isOn {
                    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                    Text("")
                        .onReceive(timer) { _ in
                            if progress < 2 {
                                progress += 0.1
                            } else {
                                
                                isOn = false
                                // present pop over
                                showPopup = true
                                if settings.vibrate == false {
                                    playSound(sound: "gong.m4a")
                                } else {
                                    UIDevice.vibrate()
                                    print("vibrating!")
                                }
                                
                            }
                        }.frame(minWidth: geometry.size.width, alignment: .center)
                }
                
                
                Text("Two Minutes Meditation")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .bold()
                    .layoutPriority(1)
                    .lineLimit(2)
                    .position(x: geometry.size.width / 2 , y: geometry.size.height / 10)
                    .frame(minWidth: geometry.size.width, alignment: .center)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                ActivityRingView(timerIsOn: $isOn, progress: $progress, frameSize: geometry.size.width / 1.5 )
                    
                    .fixedSize()
                    .position(x: geometry.size.width / 2 , y: geometry.size.height / 2)
                PushButton(isOn: $isOn, progress: $progress, size: geometry.size.width)
                    .position(x: geometry.size.width / 2 , y: isOn ? geometry.size.height / 2 : geometry.size.height / 2 + geometry.size.height / 2.6)
               
                if showPopup {
                    
                    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    
                    ZStack {
                        Color.black
                            .opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                reset()
                            }
                        
                        VStack(spacing: 20) {
                            Text("Done!").font(.title)
                                .padding()

                                .onReceive(timer) { _ in
                                    if dismissCount > 0 {
                                        dismissCount -= 1
                                    } else {
                                        reset()
                                    }
                                }
                        
                        }
            
                        .frame(width: 300, height: 300)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
                        .padding(.horizontal, 20)
                        .shadow(radius: 20)
                        .offset(x: showPopup ? 0 : -400)
                        .animation(.default)
                    }
                }
            }
           
           
        }
    }
    private func reset() {
        isOn = false
        progress = 0.0
        showPopup = false
        dismissCount = 3.0
        stopSound()
    }
}



struct TabOne_Previews: PreviewProvider {
    static var previews: some View {
        TabOne()
            .preferredColorScheme(.light)
    }
}
struct TabOne_Previews_dark: PreviewProvider {
    static var previews: some View {
        TabOne()
            .preferredColorScheme(.dark)
    }
}
