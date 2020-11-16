//
//  AppReviewRequest.swift
//  
//
//  Created by Laurent B on 15/11/2020.
//

import SwiftUI
import StoreKit

enum AppReviewRequest {

	static var threshold = 3
	@AppStorage("runSinceLastRequest") static var runsSinceLastRequest = 0
	@AppStorage("version") static var version = ""

	static func requestReviewIfNeeded() {
		runsSinceLastRequest += 1
		print("Run count \(runsSinceLastRequest)")
		let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
		let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
		let thisVersion = "\(appVersion) build: \(appBuild)"
		print("version: \(thisVersion)")

		if thisVersion != version {
			if runsSinceLastRequest >= threshold {
				if let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene {
					SKStoreReviewController.requestReview(in: scene)
					version = thisVersion
					runsSinceLastRequest = 0
				}
			}
		} else {
			runsSinceLastRequest = 0
		}

	}
}
