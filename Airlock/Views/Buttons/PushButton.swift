//
//  PushButton.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

struct PushButton: View {
    @Binding var isOn: Bool
    @Binding var progress: CGFloat
    
    let title: String = "Start"
    var size: CGFloat
    
    
    var body: some View {
        Button(action: {
            isOn.toggle()
            if !isOn {
                progress = 0.0
            }
        }, label: {
            Text(isOn ? "" : "Start")
                .font(.custom("SF-Pro-Text-Medium", size: 44))
                .foregroundColor(.white)
                .frame(width: isOn ? size / 2 : size / 2 , height: isOn ? size / 2 : size / 5 )
                .clipShape(Capsule())
                .foregroundColor(.white)
                .animation(.easeOut(duration: 0.8))
                
        }).accessibility(label: isOn ? Text("Cancel") : Text("Start 2 minutes meditation"))
    }
}
