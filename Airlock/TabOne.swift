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
                            if progress < 3 {
                                progress += 0.1
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
                
                
                Text(isOn ? "Observe Your Breath " : "Two Minutes Meditation")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .bold()
                    .position(x: geometry.size.width / 2 , y: geometry.size.height / 10)
                    .frame(minWidth: geometry.size.width, alignment: .center)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .animation(.easeIn)
                ActivityRingView(timerIsOn: $isOn, progress: $progress, frameSize: geometry.size.width / 1.5 )
                    .fixedSize()
                    .position(x: geometry.size.width / 2 , y: geometry.size.height / 2)
                PushButton(isOn: $isOn, progress: $progress, size: geometry.size.width)
                    .position(x: geometry.size.width / 2 , y: isOn ? geometry.size.height / 2 : geometry.size.height / 2 + geometry.size.height / 2.5)
               
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
                            Text("Done!").font(.title)
                                .padding()

                                .onReceive(timer) { _ in
                                    if dismissCount > 0 {
                                        dismissCount -= 1
                                    } else {
                                        reset()
                                        stopSound()
                                    }
                                }
                        
                        }
            
                        .frame(width: geometry.size.width / 1.2, height: geometry.size.width / 1.2)
                        .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue))

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
        dismissCount = 4.0
        
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
