//
//  AirlockApp.swift
//  Airlock
//
//  Created by Laurent B on 22/08/2020.
//

import SwiftUI

@main
struct AirlockApp: App {
    var settings = UserSettings()
    var body: some Scene {
        WindowGroup {
            //ContentView()
            PreLaunch()
                .environmentObject(settings)
            
        }
    }
}
