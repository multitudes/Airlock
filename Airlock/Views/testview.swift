//
//  testview.swift
//  Airlock
//
//  Created by Laurent B on 06/09/2020.
//

import SwiftUI

struct BreathView: View {
    @State private var flowerOut = false
    let coreColor: Color = Color(red: 0, green: 0.9, blue: 1.0).opacity(0.0) // petal color
    let starterColor: Color = Color(red: 0.6, green: 0.9, blue: 0.9) // center color
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack {
                ForEach(0..<3) {
                    Circle()
                        //.foregroundColor(Color(red: 0.6, green: 0.9, blue: 0.8))
                        .foregroundColor((self.flowerOut
                            ? self.starterColor
                            : self.coreColor))
                        .frame(width: 200, height: 200)
                        .offset(x: self.flowerOut ? 10 : 0)
                        .rotationEffect(.degrees(Double($0) * 120))
                        .blendMode(.hardLight)
                }
            }
            .rotationEffect(.degrees(flowerOut ? 120 : 0))
            .scaleEffect(flowerOut ? 1 : 0.05)
            .animation(Animation.easeInOut(duration: 4).delay(0.75).repeatForever(autoreverses: true))
            .onAppear() {
                self.flowerOut.toggle()
            }
        }
    }
}


struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        BreathView()
    }
}

