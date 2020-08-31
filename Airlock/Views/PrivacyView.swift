//
//  PrivacyView.swift
//  Airlock
//
//  Created by Laurent B on 31/08/2020.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        
        VStack {
            Text("Privacy Policy").font(.title).padding(40)
//            Text("This policy applies to all information submitted in our apps for iPhone and any other devices and platforms.\n").font(.subheadline)
            //Text("Information we collect:\n").font(.subheadline)
            Text("The \"Two Minutes Meditation\" App does not store any personal information about you.")
            Spacer()
        }.font(.body).padding(20).foregroundColor(Color.gradientStartRed)
        .multilineTextAlignment(.center)
        

        
        
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
