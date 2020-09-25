//
//  testSO.swift
//  Airlock
//
//  Created by Laurent B on 25/09/2020.
//

import SwiftUI

struct Ring: Shape {
  var startArcAngle: Double = 360.0

  var fillPoint: Double {
    willSet {
      startArcAngle = 360 * newValue
    }
  }

  internal var animatableData: Double {
    get { return fillPoint }
    set { fillPoint = newValue }
  }

  internal func path(in rect: CGRect) -> Path {
    let endArcAngle = 0.0

    var path = Path()

    path.addArc(center: CGPoint(x: rect.size.width / 2,
                                y: rect.size.height / 2),
                radius: rect.size.width / 2,
                startAngle: .degrees(startArcAngle - 90),
                endAngle: .degrees(endArcAngle - 90),
                clockwise: true)

    return path
  }
}

struct MainView2: View {
  @State private var fillPoint = 1.0
  @State private var animationDuration = 10.0

    @State private var animationIsOn = false
    
  private var ring: Ring {

    let ring = Ring(fillPoint: self.fillPoint)
    return ring
  }

  var body: some View {
    VStack {

        
      ring.stroke(Color.red, lineWidth: 15.0)
        .frame(width: 200, height: 200)
        .padding(40)
        .animation(.easeIn(duration: self.animationDuration))
      HStack {
        Button(action: {
         
            animationIsOn.toggle()
            if animationIsOn {
                fillPoint = 0
            } else {
                fillPoint = 1
            }
        }) {
          Text("Start")
        }
        
        Button(action: {
          
          // what should I do here?
            animationIsOn.toggle()
            if animationIsOn {
                fillPoint = 0
            } else {
                fillPoint = 1
            }
        }) {
          Text("Stop")
        }
      }
    }
  }
}

struct MainView2_Previews: PreviewProvider {
    static var previews: some View {
        MainView2()
    }
}
