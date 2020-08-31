//
//  AboutThisApp.swift
//  Airlock
//
//  Created by Laurent B on 29/08/2020.
//

import SwiftUI

struct AboutThisApp: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        ScrollView {
            Text("About This App").font(.title).bold()
                //.padding()

            Text("The concept for this app is simple. It just offers just two minutes of meditation time. You might think it is not enough, and you would be right. The purpose here is not enlightenment, but giving us the chance to come down for a short moment, and start a new activity with a fresh mind.\n\nOften we rush through things in life. From a stressful commute, or intense meeting to another challenging situation. In all these cases, are we aware that we might bring our emotions from the one to the other?\n\nTwo minutes of observing your breath are what you need to collect your thought, examine yourself and your sensation, re-base and be ready again. \nSometimes important decisions and conversations benefit from a fresh and mindful start.")
                .font(.body).padding(20)
          Spacer()
        }
        //
        //.multilineTextAlignment(.center)
    }
}

struct AboutThisApp_Previews: PreviewProvider {
    static var previews: some View {
        AboutThisApp()
    }
}
