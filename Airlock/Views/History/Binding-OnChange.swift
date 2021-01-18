//
//  Binding-OnChange.swift
//  anotherquickCoreDataTest
//
//  Created by Laurent B on 11/01/2021.
//

import SwiftUI

extension Binding {
	func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
		Binding(
			get: {self.wrappedValue},
			set: { newValue in
				self.wrappedValue = newValue
				handler()
			})
	}
}
