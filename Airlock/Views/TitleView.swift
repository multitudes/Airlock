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
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.white)
            .bold()
            .position(x: width / 2 , y: height / 10)
            .frame(minWidth: width, alignment: .center)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .animation(.easeIn)
    }
}

