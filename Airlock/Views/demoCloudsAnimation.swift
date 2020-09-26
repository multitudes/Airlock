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
        Image(systemName: "cloud.fill")
            .foregroundColor(.white)
            .font(Font.system(size: 40 + 200 * 2 * 0.03))
            .frame(width: 200, height: 200)
            .offset(y: altitude)
            .offset(x: change ? 200 + 40 : -200 - 40)
            .animation(Animation.linear(duration: duration).delay(delay))
        
    }
}

struct demoCloudsAnimation: View {
    @State var change: Bool = true
    let offset: CGFloat = 140 // will get the offset for my geo
    
    var altitudes = [CGFloat]()
    var delays : [Double] = [Double]()
    
    init() {
        for _ in 0...4 {
            self.altitudes.append(CGFloat.random(in: -150...150))
            self.delays.append(Double.random(in: 1...10))
        }
    }
    
    var body: some View {
        ZStack {
            VStack{
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.blue)
                    .padding(89)
                    .frame(width: 600, height: 600, alignment: .center)
                Button("Start") {
                    self.change.toggle()
                }
            }
            ForEach(0...4, id: \.self) { i in
                Cloud(change: change, altitude: altitudes[i] , delay: delays[i])
            }
        }
        
        
    }
    
}

struct demoCloudsAnimation_Previews: PreviewProvider {
    static var previews: some View {
        demoCloudsAnimation()
        
    }
}
