//
//  TitleView.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

struct TitleView: View {
    var isOn: Bool
    var geo: GeometryProxy
    var width: CGFloat { geo.size.width }
    var height: CGFloat { geo.size.height }
    
    var body: some View {
        Text(isOn ? "" : "Two Minutes Meditation")
            //.font(.largeTitle)
            .font(.custom("SF-Pro-Text-Medium", size: 33 + width / 40))
            .foregroundColor(.white)
            .bold()
            .padding(.horizontal)
            .position(x: width / 2 , y: height / 8)
            .frame(minWidth: width * 0.9, alignment: .center)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .animation(.easeInOut)
    }
}

