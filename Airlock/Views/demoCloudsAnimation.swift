//
//  demoCloudsAnimation.swift
//  Airlock
//
//  Created by Laurent B on 24/09/2020.
//

import SwiftUI


struct demoCloudsAnimation: View {

    @Binding var progress: CGFloat
    let geo: GeometryProxy
    

    var startingY: CGFloat { CGFloat.random(in: -geo.size.height...150) }
    
    var positionX: CGFloat { -50 - geo.size.width }
    @State var offset: CGSize = CGSize(width: -150, height: -50)

    var body: some View {
        VStack {
            Text("Progress \(geo.size.width)")
            Image(systemName: "cloud").foregroundColor(.white).font(.system(size: 60))
                .offset(CGSize(width: progress * 10 - 50, height: startingY))
        }.animation(.easeIn)

    }

}
