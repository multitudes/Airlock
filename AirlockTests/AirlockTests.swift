//
//  AirlockTests.swift
//  AirlockTests
//
//  Created by Laurent B on 23/11/2020.
//

import XCTest
@testable import Airlock

class AirlockTests: XCTestCase {
	var mainView: MainView!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		mainView = MainView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testMainView() {
		let body = mainView.body
		XCTAssertNotNil(body)
	}

    func testStartingState() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

		XCTAssertNotNil(mainView.vibrateIsOn)
		XCTAssertNotNil(mainView.meditationTimerSeconds)
		XCTAssertNotNil(mainView.progress)
		XCTAssertNotNil(mainView.isOn)
		XCTAssertNotNil(mainView.showPopup)
		XCTAssertNotNil(mainView.dismissCount)
		XCTAssertNotNil(mainView.showModal)

		XCTAssert([120, 1200, 3600].contains(mainView.meditationTimerSeconds))
		XCTAssertEqual(mainView.progress, 0)
		XCTAssertEqual(mainView.isOn, false)
		XCTAssertEqual(mainView.showPopup, false)
		XCTAssertEqual(mainView.dismissCount, 4)
		XCTAssertEqual(mainView.showModal, false)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
