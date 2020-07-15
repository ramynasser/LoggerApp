//
//  LoggerAppTests.swift
//  LoggerAppTests
//
//  Created by Ramy Nasser on 7/15/20.
//  Copyright © 2020 Ramy Nasser. All rights reserved.
//

import XCTest
@testable import LoggerApp

class LoggerAppTests: XCTestCase {
    let mockStarge = MockStarge()
    let logger = Logger.shared
     
     func test_fetch_Logger_when_change_stoarg() {
        let message = "this is an verbose message"
        logger.logItem(message, level: .verbose)
        let fetchArr = logger.fetchLogs()
        XCTAssertEqual(fetchArr.count, 1)
        let fetchItem = logger.fetchLogs().first
        XCTAssertNotNil(fetchItem?.log)
      }
    
   
    
 
    override func setUp() {
        logger.changeStorage(to: MockStarge())
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
class MockStarge:Storage {
    var arr:[LogItem] = []
    func saveLog(logItem: LogItem) {
        arr.append(logItem)
    }
    
    func getLogs() -> [LogItem] {
        return arr
    }
    
    func deleteLogs() {
        arr = []
    }
    
    
}
