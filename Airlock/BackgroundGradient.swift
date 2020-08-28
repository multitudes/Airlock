//
//  BackgroundGradient.swift
//  Airlock
//
//  Created by Laurent B on 28/08/2020.
//

import Foundation
import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gradientStartRed, Color.gradientEndRed]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()

    }
}

