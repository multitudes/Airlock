//
//  TabOne.swift
//  Airlock
//
//  Created by Laurent B on 28/08/2020.
//

import SwiftUI


struct TabOne: View {
    
    @State var progress: CGFloat = 0.0
    @State var isOn: Bool = false
    @State private var showPopup = false
    @State var dismissCount: CGFloat = 3.0
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            GeometryReader { geometry in
                
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
                                playSound(sound: "gong.m4a")
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
                //.animation(.easeInOut(duration: 0.5))
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
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                            Spacer()
                            Text("Dismissing in \(dismissCount)")
                                .font(.title)
                                .onReceive(timer) { _ in
                                    if dismissCount > 0 {
                                        dismissCount -= 1
                                    } else {
                                        reset()
                                    }
                                }
                            Spacer()
                            Text("You can also tap outside of the popup to close")
                                .font(.title)
                            Spacer()
                            Button("Or tap this button to close") {
                                reset()
                            }.padding(.bottom)
                        }
                        .frame(width: 500, height: 300)
                        .background(Color.red)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                        .padding(.horizontal, 20)
                        .offset(x: showPopup ? 200 : 150)
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



