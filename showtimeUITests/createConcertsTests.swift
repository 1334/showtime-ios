//
//  createConcertsTests.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 12/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import XCTest

class createConcertsTests: XCTestCase {
    var app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
        let firstRunAlert = app.alerts["New Run"]
        if firstRunAlert.exists {
            firstRunAlert.buttons["Nothing"].tap()
        }
    }

    func testExample() {

        let tablesQuery = app.tables
        app.tabBars.buttons["Add Concert"].tap()

        tablesQuery.cells.staticTexts["Artist"].tap()

        if(!tablesQuery.staticTexts["Adrian Borland"].exists) {
            app.navigationBars.buttons["Add"].tap()
            tablesQuery.searchFields.element.tap()
            tablesQuery.searchFields.element.typeText("adrian borland")
        }
        tablesQuery.staticTexts["Adrian Borland"].tap()


        tablesQuery.cells.staticTexts["Venue"].tap()

        if(!tablesQuery.staticTexts["Palau de la Música Catalana"].exists) {
            app.navigationBars.buttons["Add"].tap()
            tablesQuery.searchFields.element.tap()
            tablesQuery.searchFields.element.typeText("palau musica")
        }
        tablesQuery.staticTexts["Palau de la Música Catalana"].tap()

        tablesQuery.staticTexts["Date"].tap()
        tablesQuery.pickerWheels.element(boundBy: 0).swipeUp()
        tablesQuery.pickerWheels.element(boundBy: 1).swipeUp()
        tablesQuery.pickerWheels.element(boundBy: 2).swipeUp()

        tablesQuery.buttons["Add Concert"].tap()

        app.tabBars.buttons["Dashboard"].tap()
        let upcomingConcerts = tablesQuery.element(boundBy: 0)

        XCTAssert(upcomingConcerts.cells.staticTexts["Adrian Borland"].exists)
    }
    
}
