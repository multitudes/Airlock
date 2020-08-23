//
//  ContentView.swift
//  Airlock
//
//  Created by Laurent B on 22/08/2020.
//

import SwiftUI

struct ActivityRingView: View {
    @Binding var progress: CGFloat
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
        
                Text("Two Minutes Meditation")
                    .font(Font.system(size: 60))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .bold()
                    .layoutPriority(1)
                    .lineLimit(2)
                    .frame(maxWidth: 350, alignment: .center)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)

                Text("Observe your breath")
                    .frame(minWidth: 300, alignment: .center)
                    .font(.title)
                    .foregroundColor(Color.lightTitle)
                    .layoutPriority(1)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
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
                }, label: {
                    ZStack {
                        Circle()
                            .frame(width: 250, height: 250)
                            .foregroundColor(progress == 0.0 ? .buttonLightRed : Color.clear)
                        Text("Start")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    
                })
            }.frame(idealWidth:300, idealHeight: 300, alignment: .center)
            }
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
