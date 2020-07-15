//
//  CoreDataManagerTests.swift
//  LoggerAppTests
//
//  Created by Ramy Nasser on 2/29/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import XCTest
import CoreData
@testable import LoggerApp

class CoreDataManagerTests: XCTestCase {
    
    // MARK: Properties
    
    var sut: CoreDataManager!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = CoreDataManager()
    }
    
    // MARK: - Tests
    
    // MARK: Setup

    func test_setup_completionCalled() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup(storeType: NSSQLiteStoreType) {
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    
    func test_setup_persistentContainerLoadedInMemory() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup(storeType: NSSQLiteStoreType) {
            XCTAssertEqual(self.sut.persistentContainer.persistentStoreDescriptions.first?.type, NSSQLiteStoreType)
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // MARK: Contexts
    
    func test_backgroundContext_concurrencyType() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup(storeType: NSSQLiteStoreType) {
            XCTAssertEqual(self.sut.backgroundContext.concurrencyType, .privateQueueConcurrencyType)
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_mainContext_concurrencyType() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup(storeType: NSSQLiteStoreType) {
            XCTAssertEqual(self.sut.mainContext.concurrencyType, .mainQueueConcurrencyType)
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
