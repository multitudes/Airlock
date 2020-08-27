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
                
                Circle()
                    .stroke(Color.outlineLightRed, lineWidth: frameSize! / 6)
                    .opacity(0.3)
                Circle()
                    .trim(from: 0.0, to: progress / 2.0)
                    .stroke(
                        Color.white,
                        style: StrokeStyle(lineWidth: frameSize! / 6, lineCap: .round)
                    )
                    .border(Color.clear, width: 0)
                    .rotationEffect(.degrees(-90))
                    //.animation(Animation.linear(duration: 10))
                Circle()
                    .border(Color.clear, width: 0)
                    .frame(width: frameSize! / 6  , height: frameSize! / 6)
                    .foregroundColor(progress != 0 ? .white : Color.clear  )
                    .offset(y: -(frameSize! / 2 )   )
                Circle()
                    .border(Color.clear, width: 0)
                    .frame(width: frameSize! / 6, height: frameSize! / 6)
                    .offset(y: -frameSize! / 2 )
                    .foregroundColor(progress / 2 >= 0.95 ? Color.white : Color.clear)
                    .rotationEffect(Angle.degrees(360 * Double(progress / 120)))
                    .shadow(color: progress / 2 >= 0.94 ? Color.black.opacity(0.3): Color.clear, radius: frameSize! / 250 , x: frameSize! / 150, y: 0)
                
                
            }.frame(idealWidth: frameSize!, idealHeight: frameSize!, alignment: .center)
            
            
        }
    }
    
    func printHello() {
        print("hello")
    }
}

struct TabOne: View {
    
    @State var progress: CGFloat = 0.0
    @State var isOn: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.gradientStartRed, Color.gradientEndRed]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geometry in
               
                if isOn {
                    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                    Text("on! \(progress)")
                        .onReceive(timer) { _ in
                            if progress < 2 {
                                progress += 0.1
                            } else {
                                progress = 0.0
                                isOn = false
                            }
                        }.frame(minWidth: geometry.size.width, alignment: .center)
                }
//                HStack {
//                    Spacer()
//                    Button(action: {
//                     // code
//                    }) {
//
//                        Image(systemName: "line.horizontal.3")
//                            .foregroundColor(.white)
//                            .font(.title)
//                            .padding()
//                    }
//                }
                
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
                PushButton(isOn: $isOn, size: geometry.size.width)
                    .position(x: geometry.size.width / 2 , y: isOn ? geometry.size.height / 2 : geometry.size.height / 2 + geometry.size.height / 2.6)
                    .animation(.easeInOut(duration: 0.5))
                
            }
            
        }
    }
}

struct TabTwo: View {
    
    var body: some View {
    Text("not yet!")
    }
}

struct ContentView: View {
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
    let title: String = "Start"
    var size: CGFloat
    var onColors = [Color.gradientStartRed, Color.buttonLightRed]
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()

        }, label: {
            Text(isOn ? "Cancel" : "Start")
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(width: isOn ? size / 2 : size / 2 , height: isOn ? size / 2 : size / 6 )
                .background(LinearGradient(gradient: Gradient(colors: onColors ), startPoint: .top, endPoint: .bottom))
                .clipShape(Capsule())
                .foregroundColor(.white)
                .shadow(color: Color.red ,radius: 5)
                .animation(.easeInOut(duration: 0.7))
        }).accessibility(label: isOn ? Text("Cancel") : Text("Start 2 minutes meditation"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
