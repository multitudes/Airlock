//
//  PushButton.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

@discardableResult
func log(_ message: String, _ file: String = #file, _ line:Int = #line, _ function: String = #function) -> String {
	let logMessage = "[\(file):\(line)] \(function) - \(message)"
	print(logMessage)
	return logMessage
}

struct PushButton: View {
    @Binding var isOn: Bool
    @Binding var progress: CGFloat
    
    let title: String = "Start"
    var size: CGFloat
    var onColors = [Color.gradientStartRed, Color.buttonLightRed]
    
    var body: some View {
        Button(action: {
            isOn.toggle()
			log("Button pressed")
            if !isOn {
                progress = 0.0
            }
        }, label: {
            Text(isOn ? "Cancel" : "  Start  ") // the whitespaces in "Start" are there to avoid animation irregularities
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: isOn ? size / 2 : size / 2 , height: isOn ? size / 2 : size / 5 )
                .clipShape(Capsule())
                .foregroundColor(.white)
                .animation(.easeOut(duration: 0.8))
                
        }).keyboardShortcut(" ", modifiers: [])
		.accessibility(label: isOn ? Text("Cancel") : Text("Start 2 minutes meditation"))
    }
}
