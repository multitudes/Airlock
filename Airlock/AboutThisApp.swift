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
        VStack {
            Text("Hello, World!")
            Text("Volume: \(settings.volume)")
            
        }
    }
}

struct AboutThisApp_Previews: PreviewProvider {
    static var previews: some View {
        AboutThisApp()
    }
}
