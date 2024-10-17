//
//  CoreDataTestUITests.swift
//  CoreDataTestUITests
//
//  Created by GHALILA Marwane on 16/10/2024.
//

import XCTest

@testable import CoreDataTest
final class CoreDataTestUITests: XCTestCase {
    var viewModel = MainViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGiven_WhenLoginFalse() {
        viewModel.isValid = true
        let a = "jack"
        let b = "black"
        let awaitedResult1 = false
        
        XCTAssert(awaitedResult1 != viewModel.isValid )
        
        viewModel.checkConnection(login: a, password: b)
        
        XCTAssertTrue(viewModel.isValid == awaitedResult1)
    }
    
    func testGiven_WhenLoginTrue() {
        viewModel.isValid = true
        let a = "Jean"
        let b = "12345"
        let awaitedResult1 = true
        let answer1 = false
        XCTAssert(awaitedResult1 != answer1 )
        
        viewModel.checkConnection(login: a, password: b)
        
        XCTAssertTrue(viewModel.isValid == awaitedResult1)
    }
    
    func testGiven_WhenLoginTrueandFalse() {
        viewModel.isValid = true
        let a = "Jean"
        let b = "1"
        let awaitedResult1 = false
        XCTAssert(awaitedResult1 != viewModel.isValid )
        
        viewModel.checkConnection(login: a, password: b)
        
        XCTAssertTrue(viewModel.isValid == awaitedResult1)
    }

}
