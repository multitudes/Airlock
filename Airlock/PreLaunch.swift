//
//  PreLaunch.swift
//  Airlock
//
//  Created by Laurent B on 07/09/2020.
//

import SwiftUI

struct PreLaunch: View {
    
    @State var showMainView = false
    @State var opacity: Double = 0
    
    var body: some View {
        Group {
            if showMainView {
				MainView()
            } else {
                ZStack {
                    BackgroundGradient()
                        .opacity(opacity)
                }
            }
        }
		.onAppear {
            withAnimation(.linear(duration: 2)) {
                opacity = 1
                showMainView = true
            }
        }
    }
}

struct PreLaunch_Previews: PreviewProvider {
    static var previews: some View {
        PreLaunch()
    }
}
