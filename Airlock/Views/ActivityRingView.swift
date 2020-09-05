//
//  ActivityRingView.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

struct ActivityRingView: View {
    @Binding var timerIsOn: Bool
    @Binding var progress: CGFloat
    var meditationTime: CGFloat = 120.0
    var frameSize: CGFloat?
    var lineWidth: CGFloat { frameSize! * 1.07 / 9.93 }
    var strokeColor: Color {
        Color.outlineLightRed
    }
    
    var body: some View {
        
        ZStack {
            ZStack {
                // the light red shadow
                Circle()
                    .stroke(strokeColor, lineWidth: lineWidth)
                    .opacity(0.3)
                // the white progress circle
                Circle()
                    .trim(from: 0.0, to: progress / meditationTime)
                    .stroke(
                        Color.white,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .border(Color.clear, width: 0)
                    .rotationEffect(.degrees(-90))

                // the rounded start
                Circle()
                    .border(Color.clear, width: 0)
                    .frame(width: lineWidth  , height: lineWidth)
                    .foregroundColor(progress != 0 ? .white : Color.clear  )
                    .offset(y: -(frameSize! / 2 )   )
                Circle()
                    .border(Color.clear, width: 0)
                    .frame(width: lineWidth, height: lineWidth)
                    .offset(y: -frameSize! / 2 )
                    .foregroundColor(progress / meditationTime  >= 0.97 ? Color.white : Color.clear)
                    .rotationEffect(Angle.degrees(360 * Double(progress / 120)))
                    .shadow(color: progress / meditationTime >= 0.97 ? Color.black.opacity(0.2): Color.clear, radius: frameSize! / 250 , x: frameSize! / 250, y: 0)
                
            }.frame(idealWidth: frameSize!, idealHeight: frameSize!, alignment: .center)
        }
    }
}

