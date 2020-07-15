//
//  NSPersistentContainer+Store.swift
//  LoggerAppTests
//
//  Created by Ramy Nasser on 2/28/20.
//  Copyright © 2020 Ramy. All rights reserved.
//

import Foundation
import Foundation
import CoreData
@testable import LoggerApp

extension NSPersistentContainer {
    
    func destroyPersistentStore() {
        guard let storeURL = persistentStoreDescriptions.first?.url,
            let storeType = persistentStoreDescriptions.first?.type else {
            return
        }
        
        do {
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel())
            try persistentStoreCoordinator.destroyPersistentStore(at: storeURL, ofType: storeType, options: nil)
        } catch let error {
            print("failed to destroy persistent store at \(storeURL), error: \(error)")
        }
    }
}
