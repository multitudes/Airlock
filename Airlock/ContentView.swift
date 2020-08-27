//
//  ContentView.swift
//  Airlock
//
//  Created by Laurent B on 22/08/2020.
//

import SwiftUI

struct ActivityRingView: View {
    @State private var timerIsOn: Bool = false
    @Binding var progress: CGFloat
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(Color.outlineLightRed, lineWidth: 30)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    Color.white,
                    style: StrokeStyle(lineWidth: 30, lineCap: .round)
                ).rotationEffect(.degrees(-90))
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(progress != 0.0 ? .white : Color.clear  )
                .offset(y: -150)
            Circle()
                .border(Color.clear, width: 0)
                .frame(width: 30, height: 30)
                .offset(y: -150)
                .foregroundColor(progress >= 0.95 ? Color.white : Color.clear)
                .rotationEffect(Angle.degrees(360 * Double(progress)))
                .shadow(color: progress > 0.95 ? Color.black.opacity(0.3): Color.clear, radius: 1, x: 1, y: 0)
            
            Button(action: {
                printHello()
                timerIsOn = true
            }, label: {
                if !timerIsOn {
                    ZStack {
                        Circle()
                            .frame(width: 250, height: 250)
                            .foregroundColor(progress == 0.0 ? .buttonLightRed : Color.clear)
                        Text("Start")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .accessibility(label: Text("Start two minutes"))
                } else {
                    ZStack {
                        Circle()
                            .frame(width: 250, height: 250)
                            .foregroundColor(progress == 0.0 ? .buttonLightRed : Color.clear)
                        Text("Start")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .accessibility(label: Text("Start two minutes"))
                }
            })
        }.frame(idealWidth:300, idealHeight: 300, alignment: .center)
    }
    
    
    func printHello() {
        print("hello")
    }
}

struct ContentView: View {
    @State private var progress: CGFloat = 0.00
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.gradientStartRed, Color.gradientEndRed]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                
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
            }
            
            ActivityRingView(progress: $progress)
                .fixedSize()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
