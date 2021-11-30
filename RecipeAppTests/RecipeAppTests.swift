//
//  RecipeAppTests.swift
//  RecipeAppTests
//
//  Created by Dina ElShabassy on 11/24/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import XCTest
@testable import RecipeApp

class RecipeAppTests: XCTestCase {
    
    var networkModel : NetworkModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkModel = NetworkModel()
    }
    
    func testGetRecipes() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectationsObj = expectation(description: "wait for response")
        networkModel.fetchSearchResult(searchKeyword: "chicken") { (result, error) in
            if let result = result{
                expectationsObj.fulfill()
                //XCTAssertFalse(result.hits?.count != 0) //test failed
                XCTAssertTrue(result.hits?.count == 20) // test succeeded
            }
            else{
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 3)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkModel = nil
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
