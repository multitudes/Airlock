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
			Text("\nThe best ideas are coming when the mind is relaxed and alert at the same time.\n\nThis app will allow you to practice, with the option to record your thoughts in a diary.\nOur brain works in different modes. There is the focused mode, which helps us to solve problems but is sometimes missing the big picture. There is the diffused mode, able to work in the background which is good for creativity, and then there is the meditative mode which is both alert and relaxed at the same time. This app allows you to practice short two minutes meditations. You can meditate any way you like, concentrating on your breath or sensations on your body. Try concentrating single-mindedly, remaining aware at all times. If your mind wanders, bring her back.\n\nKeep your equanimity. Accept the present moment and observe it. After the meditation, you can write a note to your future self, and save them to a file, visible in the Files app on your device.\nWhen you feel ready, a long press on the title, allows you to select a longer meditation time.\n\nI hope you enjoy using this app!")
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
