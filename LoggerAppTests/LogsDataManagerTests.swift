//
//  ColorsDataManagerTests.swift
//  LoggerAppTests
//
//  Created by Ramy Nasser on 2/28/20.
//  Copyright © 2020 Ramy. All rights reserved.
//

import XCTest
@testable import LoggerApp
import CoreData
class LogsDataManagerTests: XCTestCase {
    // MARK: Properties
        
        var sut: LogsDataManager!
        
        var coreDataStack: CoreDataTestStack!
        
        // MARK: - Lifecycle
        
        override func setUp() {
            super.setUp()
            
            coreDataStack = CoreDataTestStack()
            
            sut = LogsDataManager(backgroundContext: coreDataStack.backgroundContext)
        }
       
        // MARK: Init
        
        func test_init_contexts() {
            XCTAssertEqual(sut.backgroundContext, coreDataStack.backgroundContext)
        }
        
        // MARK: Create
        
        func test_createLog() {
            let performAndWaitExpectation = expectation(description: "background perform and wait")
            coreDataStack.backgroundContext.expectation = performAndWaitExpectation
            let log = LogItem(log: "messagae", date: Date())
            sut.createLog(log: log)

            waitForExpectations(timeout: 1) { (_) in
                let request = NSFetchRequest<Log>.init(entityName: Log.className)
                let logs = try! self.coreDataStack.backgroundContext.fetch(request)
                
                guard let log = logs.first else {
                    XCTFail("log missing")
                    return
                }
                
                XCTAssertEqual(logs.count, 1)
                XCTAssertNotNil(log.content)
                XCTAssertTrue(self.coreDataStack.backgroundContext.saveWasCalled)
            }
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
