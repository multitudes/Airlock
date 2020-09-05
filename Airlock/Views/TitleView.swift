//
//  TitleView.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

struct TitleView: View {
    var isOn: Bool
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Text(isOn ? "Observe Your Breath " : "Two Minutes Meditation")
            //.font(.largeTitle)
            .font(.custom("SF-Pro-Display-Medium", size: 33 + width / 40))
            .foregroundColor(.white)
            .bold()
            .padding(.horizontal)
            .position(x: width / 2 , y: height / 9)
            .frame(minWidth: width * 0.9, alignment: .center)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .animation(.easeIn)
    }
}

