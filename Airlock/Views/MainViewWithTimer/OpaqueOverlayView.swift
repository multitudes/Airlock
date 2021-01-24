//
//  OpaqueOverlayView.swift
//  Airlock
//
//  Created by Laurent B on 16/11/2020.
//

import SwiftUI

struct OpaqueOverlayView: View {
    var body: some View {
		Color.black
			.opacity(0.7)
			.edgesIgnoringSafeArea(.all)
    }
}

struct OpaqueOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        OpaqueOverlayView()
    }
}
