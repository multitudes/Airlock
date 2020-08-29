//
//  ContentView.swift
//  Airlock
//
//  Created by Laurent B on 22/08/2020.
//

import SwiftUI

struct ActivityRingView: View {
    @Binding var timerIsOn: Bool
    @Binding var progress: CGFloat
    var frameSize: CGFloat?
    
    var body: some View {
        
        ZStack {
            ZStack {
                // the light red shadow
                Circle()
                    .stroke(Color.outlineLightRed, lineWidth: frameSize! / 6)
                    .opacity(0.3)
                // the white progress circle
                Circle()
                    .trim(from: 0.0, to: progress / 3.0)
                    .stroke(
                        Color.white,
                        style: StrokeStyle(lineWidth: frameSize! / 6, lineCap: .round)
                    )
                    .border(Color.clear, width: 0)
                    .rotationEffect(.degrees(-90))

                // the rounded start
                Circle()
                    .border(Color.clear, width: 0)
                    .frame(width: frameSize! / 6  , height: frameSize! / 6)
                    .foregroundColor(progress != 0 ? .white : Color.clear  )
                    .offset(y: -(frameSize! / 2 )   )
                Circle()
                    .border(Color.clear, width: 0)
                    .frame(width: frameSize! / 6, height: frameSize! / 6)
                    .offset(y: -frameSize! / 2 )
                    .foregroundColor(progress / 3 >= 0.97 ? Color.white : Color.clear)
                    .rotationEffect(Angle.degrees(360 * Double(progress / 120)))
                    .shadow(color: progress / 3 >= 0.97 ? Color.black.opacity(0.2): Color.clear, radius: frameSize! / 250 , x: frameSize! / 250, y: 0)
                
            }.frame(idealWidth: frameSize!, idealHeight: frameSize!, alignment: .center)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    @State private var selectedTab = 1 // Set which tab is active
    var body: some View {
        
        TabView(selection: $selectedTab) {
            TabOne().tabItem {
                VStack {
                    Image(systemName: "goforward")
                    Text("2 Minutes")
                }
            }.tag(1)
            TabTwo().tabItem {
                VStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }.tag(2)
        }
        .edgesIgnoringSafeArea(.all)
        .accentColor(.red)
        
    }
}

struct PushButton: View {
    @Binding var isOn: Bool
    @Binding var progress: CGFloat
    @State private var showPopup = true
    
    let title: String = "Start"
    var size: CGFloat
    var onColors = [Color.gradientStartRed, Color.buttonLightRed]
    
    var body: some View {
        Button(action: {
            isOn.toggle()
            if !isOn {
                progress = 0.0
            }
        }, label: {
            Text(isOn ? "Cancel" : "Start")
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(width: isOn ? size / 2 : size / 2 , height: isOn ? size / 2 : size / 6 )
                .background(LinearGradient(gradient: Gradient(colors: onColors ), startPoint: .top, endPoint: .bottom))
                .clipShape(Capsule())
                .foregroundColor(.white)
                .shadow(color: Color.red ,radius: isOn ? 50 : 5)
                .animation(.easeOut(duration: 0.8))
                
        }).accessibility(label: isOn ? Text("Cancel") : Text("Start 2 minutes meditation"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
