//
//  AboutThisApp.swift
//  Airlock
//
//  Created by Laurent B on 29/08/2020.
//

import SwiftUI

struct AboutThisApp: View {

	var body: some View {
        ScrollView {
            Text("About This App").font(.title).bold()

            
            Text("We are inviting you to close your eyes and observe your breath for two minutes, the bare minimum of a unit of time. But did you ever realise how long are two minutes when you close your eyes? \n\nThe concept of the app is simple. \nYou press the button and start to meditate, giving awareness to your breath, just observing. You might think two minutes is not enough, and you would be right, but the purpose here is not enlightenment, but getting the chance to come down for a moment, and get a fresh mind.\n\nOften we rush through things in life. From a stressful commute, an intense meeting to another challenging situation. In all these cases, are we often not aware of how we carry our emotions from place to place, meeting to meeting.\n\nTwo minutes of observing your breath are what you need to collect your thought, examine yourself and your sensation, re-base and be ready again. \n\nSometimes important decisions and conversations benefit from a fresh and mindful start.")
                .font(.body).padding(20)
          Spacer()
        }
    }
}

struct AboutThisApp_Previews: PreviewProvider {
    static var previews: some View {
        AboutThisApp()
    }
}
