////
////  anotherquickCoreDataTestApp.swift
////  anotherquickCoreDataTest
////
////  Created by Laurent B on 09/01/2021.
////
//
//import SwiftUI
//
//@main
//struct anotherquickCoreDataTestApp: App {
//	@StateObject var dataController: DataController
//
//	init() {
//		let dataController = DataController()
//		_dataController = StateObject(wrappedValue: dataController)
//	}
//
//    var body: some Scene {
//        WindowGroup {
//            HistoryView()
//				.environment(\.managedObjectContext, dataController.container.viewContext)
//				.environmentObject(dataController)
//        }
//    }
//}
