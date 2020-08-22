//
//  ContentView.swift
//  Airlock
//
//  Created by Laurent B on 22/08/2020.
//

import SwiftUI

struct ActivityRingView: View {
    @Binding var progress: CGFloat
    
    var colors: [Color] = [Color.darkRed, Color.lightRed]
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.outlineRed, lineWidth: 40)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: colors), center: .center,
                        startAngle: .degrees(0), endAngle: .degrees(360)
                    ),
                    style: StrokeStyle(lineWidth: 40, lineCap: .round)
                ).rotationEffect(.degrees(-90))
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(.darkRed)
                .offset(y: -150)
            Circle()
                .frame(width: 40, height: 40)
                .offset(y: -150)
                .foregroundColor(progress > 0.95 ? Color.lightRed: Color.lightRed.opacity(0))
                .rotationEffect(Angle.degrees(360 * Double(progress)))
                .shadow(color: progress > 0.95 ? Color.black.opacity(0.2): Color.clear, radius: 8, x: 8, y: 0)
        }.frame(idealWidth:300, idealHeight: 300, alignment: .center)
    }
    
}

struct ContentView: View {
    @State private var progress: CGFloat = 1
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "F83480"), Color(hex: "FA1859")]), startPoint: .top, endPoint: .bottom)
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
