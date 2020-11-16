//
//  EndPopUpView.swift
//  Airlock
//
//  Created by Laurent B on 16/11/2020.
//

import SwiftUI

struct EndPopUpView: View {
	var dismissCount: Int
	var width: CGFloat
	var innerRingOffset: CGFloat = 40

    var body: some View {
		VStack {

			Text("Done!")
				.font(.largeTitle).bold()
				.padding()
			VStack {
				Text("Dismissing in :")
				Text("\(dismissCount)")
					.font(.title3)
			}

		}
		.frame(width: width / 1.2, height: width / 1.2)
		.foregroundColor(.white)
		.overlay(
			Circle()
				.stroke(Color.white, lineWidth: 15)
				.frame(width: width / 1.2 - innerRingOffset, height: width / 1.2 - innerRingOffset))
		.background(Circle()
						.fill(LinearGradient(gradient: Gradient(colors: [Color.gradientStartRed, Color.gradientEndRed]), startPoint: .top, endPoint: .bottom)))
    }
}

struct EndPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        EndPopUpView(dismissCount: 4, width: 300)
    }
}
