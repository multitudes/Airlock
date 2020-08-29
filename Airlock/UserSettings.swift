//
//  UserSettings.swift
//  Airlock
//
//  Created by Laurent B on 29/08/2020.
//

import Foundation
import SwiftUI

class UserSettings: ObservableObject {
    @Published var volume: Float = 0.5
    @Published var vibrate: Bool = false
}
