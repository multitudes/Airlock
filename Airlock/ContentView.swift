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
    var frameSize: CGFloat?
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(Color.outlineLightRed, lineWidth: frameSize! / 5)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    Color.white,
                    style: StrokeStyle(lineWidth: frameSize! / 5, lineCap: .round)
                ).rotationEffect(.degrees(-90))
            Circle()
                .frame(width: frameSize! / 5 , height: frameSize! / 5)
                .foregroundColor(progress != 0.0 ? .white : Color.clear  )
                .offset(y: -frameSize! / 2)
            Circle()
                .border(Color.clear, width: 0)
                .frame(width: frameSize! / 5, height: frameSize! / 5)
                .offset(y: -frameSize! / 2)
                .foregroundColor(progress >= 0.95 ? Color.white : Color.clear)
                .rotationEffect(Angle.degrees(360 * Double(progress)))
                .shadow(color: progress > 0.95 ? Color.black.opacity(0.3): Color.clear, radius: 1, x: 1, y: 0)
            
            Button(action: {
                printHello()
                timerIsOn.toggle()
            }, label: {
                if timerIsOn {
                    ZStack {
                        Circle()
                            .frame(width: 250, height: 250)
                            .foregroundColor(progress == 0.0 ? .buttonLightRed : Color.clear)
                        Text("Cancel")
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
        }.frame(idealWidth: frameSize, idealHeight: frameSize, alignment: .center)
    }
    
    
    func printHello() {
        print("hello")
    }
}

struct ContentView: View {
    @State private var progress: CGFloat = 0.99
    
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
                ActivityRingView(progress: $progress, frameSize: geometry.size.width / 2 )
                    .fixedSize()
                    .position(x: geometry.size.width / 2 , y: geometry.size.height / 2)
            }
            

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
