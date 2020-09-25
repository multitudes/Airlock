//
//  demoCloudsAnimation.swift
//  Airlock
//
//  Created by Laurent B on 24/09/2020.
//

import SwiftUI


struct Cloud: View {
    
    var change: Bool = true
    let offset: CGFloat
    let altitudeCloud: CGFloat

    var body: some View {
        Image(systemName: "cloud")
            .foregroundColor(.primary)
            .font(Font.system(size: 40 + offset * 2 * 0.03))
            .frame(width: 200, height: 200)
            .offset(y: altitudeCloud)
    }
}

struct demoCloudsAnimation: View {
    //  let geo: GeometryProxy
    @State var change: Bool = true
    let offset: CGFloat // will get the offset for my geo
    
    // taking the width and dividing it by ten points per second I get the duration for my animation
    var duration: Double {
        if !change {
            return 0
        }
        return Double((offset + offset ) / 10)
    }

    var body: some View {
        ZStack {
            Cloud(change: change, offset: offset, altitudeCloud: offset)
                .offset(x: change ? offset + 40 : -offset - 40)
                .animation(.easeOut(duration: duration))
//            Cloud(change: change, offset: offset)
//                .offset(x: change ? offset + 40 : -offset - 40)
//                .animation(.easeOut(duration: duration))

            Button("Change") {
                self.change.toggle()
            }
        }
        
        
    }
    
}

struct demoCloudsAnimation_Previews: PreviewProvider {
    static var previews: some View {
        demoCloudsAnimation(offset: 160)
        
    }
}
