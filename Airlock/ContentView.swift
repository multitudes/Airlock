//
//  ContentView.swift
//  Airlock
//
//  Created by Laurent B on 22/08/2020.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    @State private var selectedTab = 1 // Set which tab is active
    var body: some View {
            TabOne()
                .edgesIgnoringSafeArea(.bottom)
                .accentColor(.red)
            //TabTwo()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
