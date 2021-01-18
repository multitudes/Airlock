//
//  AirlockApp.swift
//  Airlock
//
//  Created by Laurent B on 22/08/2020.
//

import SwiftUI

@main
struct AirlockApp: App {
	@StateObject var dataController: DataController

	init() {
		let dataController = DataController()
		_dataController = StateObject(wrappedValue: dataController)
	}

    var body: some Scene {
        WindowGroup {
            PreLaunch()
				.environment(\.managedObjectContext, dataController.container.viewContext)
				.environmentObject(dataController)
        }
    }
}


