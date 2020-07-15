//
//  FormattersTestCase.swift
//  LoggerAppTests
//
//  Created by Ramy Nasser on 2/28/20.
//  Copyright © 2020 Ramy. All rights reserved.
//

import XCTest
@testable import LoggerApp

class FormattersTestCase: XCTestCase {
    let mockStarge = MockStarge()

    func test_formatter_with_logger() {
        let message = "this is an message"
        let logger = Logger.shared
        logger.changeStorage(to: MockStarge())
        logger.setup(formatter: .default)
        logger.logItem(message, level: .error)
        let fetchItem = logger.fetchLogs().first
           
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date = dateFormatter.string(from: fetchItem?.date ?? Date()) // string purpose I add here

       XCTAssertNotNil(fetchItem?.log)
       XCTAssert(fetchItem!.log.contains(date))

       }
   
    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
