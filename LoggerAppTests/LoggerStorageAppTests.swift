//
//  LoggerStorageAppTests.swift
//  LoggerAppTests
//
//  Created by Ramy Nasser on 2/28/20.
//  Copyright © 2020 Ramy. All rights reserved.
//

import XCTest
import CoreData

@testable import LoggerApp

class LoggerStorageAppTests: XCTestCase {

//    let coreDataManager = CoreDataManager(modelName: "Logs")
    let fileStorage = FileStorage()

    func test_fileStorage_when_fetch() {
        let log = LogItem(log: "log message 1 \n \n", date: Date())
        fileStorage.saveLog(logItem: log)
        XCTAssertTrue(fileStorage.getLogs().count == 1)
    }
    
    func test_fileStorage_when_delete() {
        let log = LogItem(log: "log message 1 \n \n", date: Date())
        fileStorage.saveLog(logItem: log)
        fileStorage.saveLog(logItem: log)
        fileStorage.saveLog(logItem: log)
        fileStorage.saveLog(logItem: log)
        fileStorage.saveLog(logItem: log)
        fileStorage.deleteLogs()
        XCTAssertTrue(fileStorage.getLogs().count == 0, "delete file content don't work")
    }
  func test_coreDataStorage_when_fetch() {
    let coreDataStack = CoreDataTestStack()
    
    let sut = LogsDataManager(backgroundContext: coreDataStack.backgroundContext)
    let coreStorage = DatabaseStorage(coreDataManager: sut)

      let log = LogItem(log: "log message 1", date: Date())
      coreStorage.saveLog(logItem: log)
      XCTAssertEqual(coreStorage.getLogs().count, 1)
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

