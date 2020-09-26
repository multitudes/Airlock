//
//  BreathView.swift
//  Airlock
//
//  Created by Laurent B on 06/09/2020.
//

import SwiftUI

struct BreathView: View {
    @State private var expanded = false
   // let coreColor: Color = Color.outlineLightRed.opacity(0.5)
    let coreColor: Color = Color(red: 0, green: 0.9, blue: 1.0) // petal color
    let starterColor: Color = Color(red: 0.6, green: 0.9, blue: 0.9) // center color
    
    var body: some View {
        ZStack {

            ZStack {
                ForEach(0..<3) {
                    Circle()
                        //.foregroundColor(Color(red: 0.6, green: 0.9, blue: 0.8))
                        .foregroundColor((expanded
                            ? self.coreColor
                            : self.starterColor))
                        .frame(width: 200, height: 200)
                        .offset(x: expanded ? 10 : 0)
                        .rotationEffect(.degrees(Double($0) * 120))
                        .blendMode(.plusLighter)
                }
            }
            .rotationEffect(.degrees(expanded ? 120 : 0))
            .scaleEffect(expanded ? 1 : 0.9)
            .animation(Animation.easeInOut(duration: 4).delay(0.75).repeatForever(autoreverses: true))
            .onAppear() {
                self.expanded.toggle()
            }
        }
    }
}


struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        BreathView()
    }
}

