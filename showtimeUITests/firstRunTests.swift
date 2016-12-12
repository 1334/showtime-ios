//
//  firstRunTests.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 12/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import XCTest

class firstRunTests: XCTestCase {
    var app: XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append("isTestingFirstRun")
        return app
    }

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testDoNothing() {
        app.alerts["New Run"].buttons["Nothing"].tap()
        XCTAssert(app.tabBars.buttons["Dashboard"].isSelected)
    }

    func testAddConcert() {
        app.alerts["New Run"].buttons["Add Concert"].tap()
        XCTAssert(app.tabBars.buttons["Add Concert"].isSelected)
    }

    func testLoadSampleData() {
        app.alerts["New Run"].buttons["Load Sample Data"].tap()
        XCTAssert(app.tables.element(boundBy: 0).staticTexts["The Jesus and Mary Chain"].exists)

    }

}

