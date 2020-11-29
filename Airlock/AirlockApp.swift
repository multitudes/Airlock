//
//  AirlockApp.swift
//  Airlock
//
//  Created by Laurent B on 22/08/2020.
//

import SwiftUI
import CoreData



@main
struct AirlockApp: App {
	let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
           // PreLaunch()
			LogView()
				.environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
    }
}
