//
//  demoCloudsAnimation.swift
//  Airlock
//
//  Created by Laurent B on 24/09/2020.
//

import SwiftUI


struct Cloud: View {
    var change: Bool
    var duration: Double
    let offset: CGFloat
    let altitude: CGFloat
    let delay: Double
    
    var body: some View {
        Image(systemName: "cloud.fill")
            .foregroundColor(.white)
            .opacity(0.7)
            .font(Font.system(size: 40 + offset * 0.6))
            .offset(x: change ? offset + 140  : -offset - 200)
            .offset(y: altitude)
			.accessibility(hidden: true)
            .animation(Animation.linear(duration: change ? duration + delay * 0.1 : 0).delay(change ? delay : 0))
      }
}

struct demoCloudsAnimation: View {
    @Binding var change: Bool
    var screenWidth: CGFloat
    var offset: CGFloat { screenWidth / 2}
    var duration: Double {
        if change {
            return Double((screenWidth ) / 10)
        }
        return 0
    }

    var altitude :CGFloat
    @Binding var delay : Double
    
    init(change: Binding<Bool> ,screenWidth: CGFloat, delay: Binding<Double>) {
        self.screenWidth = screenWidth
        self._change = change
        self.altitude = CGFloat.random(in: -screenWidth/2...screenWidth/2)
        self._delay = delay
    }
    
    var body: some View {
        ZStack {
//            VStack{
//                RoundedRectangle(cornerRadius: 25.0)
//                    .foregroundColor(.blue)
//                    .padding(89)
//                    .frame(width: 600, height: 600, alignment: .center)
//                Button("Start") {
//                    self.change.toggle()
//                }
//            }
                Cloud(change: change, duration: duration, offset: offset, altitude: altitude, delay: delay)
        }
    }
}

struct demoCloudsAnimation_Previews: PreviewProvider {
    static var previews: some View {
        demoCloudsAnimation(change: .constant(true), screenWidth: 400, delay: .constant(2))
        
    }
}
