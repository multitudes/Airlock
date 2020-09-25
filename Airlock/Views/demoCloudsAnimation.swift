//
//  demoCloudsAnimation.swift
//  Airlock
//
//  Created by Laurent B on 24/09/2020.
//

import SwiftUI


struct Cloud: View, Hashable, Equatable {
    static func == (lhs: Cloud, rhs: Cloud) -> Bool {
        lhs.altitude == rhs.altitude
    }
    var duration: Double {
        if !change {
            return 0
        }
        return Double((240 ) / 10)
    }
    
    var change: Bool
    //let offset: CGFloat
    let altitude: CGFloat
    let delay: Double
    var body: some View {
        Image(systemName: "cloud")
            .foregroundColor(.primary)
            .font(Font.system(size: 40 + 200 * 2 * 0.03))
            .frame(width: 200, height: 200)
            .offset(y: altitude)
            .offset(x: change ? 200 + 40 : -200 - 40)
            .animation(Animation.linear(duration: duration).delay(delay))
        
    }
}

struct demoCloudsAnimation: View {
    //  let geo: GeometryProxy
    @State var change: Bool = true
    let offset: CGFloat // will get the offset for my geo
    
    // taking the width and dividing it by ten points per second I get the duration for my animation
    
    
    var altitudes : [CGFloat] = [100, 150, -50 , 55, 105, 111, -100, 21, -55, -21
    ]
    var delays : [Double] = [1, 2, 3 , 4, 5, 6, 7, 8, 9, 10
    ]
    
    var body: some View {
        ZStack {
            ForEach(0...9, id: \.self) { i in
                Cloud(change: change, altitude: altitudes[i] , delay: delays[i])
            }
            
            
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
