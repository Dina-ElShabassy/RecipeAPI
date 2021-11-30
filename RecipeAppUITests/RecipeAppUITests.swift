//
//  RecipeAppUITests.swift
//  RecipeAppUITests
//
//  Created by Dina ElShabassy on 11/30/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import XCTest

class RecipeAppUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testFailSearchInput() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let inValidInput = "فراخ"
        let searchBar = app.navigationBars["RecipeApp.RecipeSearchView"]/*@START_MENU_TOKEN@*/.searchFields["Search for recipe name"]/*[[".staticTexts.searchFields[\"Search for recipe name\"]",".searchFields[\"Search for recipe name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        searchBar.typeText(inValidInput)
        
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let alert = app.alerts["Invalid input"]
        XCTAssertTrue(alert.exists)
        alert.tap()
        
        let alertButton = alert.buttons["Ok"]
        XCTAssertTrue(alertButton.exists)
        alertButton.tap()

        let anotherInvalidInput = "  "
        searchBar.tap()
        searchBar.typeText(anotherInvalidInput)

        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        XCTAssertTrue(alert.exists)
        alert.tap()

        XCTAssertTrue(alertButton.exists)
        alertButton.tap()
                
    }

    func testSuccessSearchInput() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let validInput = "Chicken"
        let searchBar = app.navigationBars["RecipeApp.RecipeSearchView"]/*@START_MENU_TOKEN@*/.searchFields["Search for recipe name"]/*[[".staticTexts.searchFields[\"Search for recipe name\"]",".searchFields[\"Search for recipe name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        searchBar.typeText(validInput)
        
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
                
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
