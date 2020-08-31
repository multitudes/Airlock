//
//  ContentView.swift
//  Airlock
//
//  Created by Laurent B on 22/08/2020.
//

import SwiftUI


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
