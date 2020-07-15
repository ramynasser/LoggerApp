//
//  ColorsDataManager.swift
//  LoggerApp
//
//  Created by Ramy Nasser on 2/28/20.
//  Copyright © 2020 Ramy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LogsDataManager {
 
    let backgroundContext: NSManagedObjectContext
    
    // MARK: - Init
    
    init(backgroundContext: NSManagedObjectContext = CoreDataManager.shared.backgroundContext) {

        self.backgroundContext = backgroundContext
    }
    
    // MARK: - Create
    func createLog(log:LogItem) {
        backgroundContext.performAndWait {
            let color = NSEntityDescription.insertNewObject(forEntityName: Log.className, into: backgroundContext) as! Log
            color.content = log.log
            color.createdAt = log.date
            
            try! backgroundContext.save()
        }
    }
   func fetchRecords() -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Log")
      // Add Sort Descriptor
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        // Helpers
        var result = [NSManagedObject]()
        do {
            // Execute Fetch Request
            let records = try backgroundContext.fetch(fetchRequest)
            if let records = records as? [NSManagedObject] {
                result = records
            }

        } catch {
            print("Unable to fetch managed objects")
        }
  
        return result
    }
    // MARK: - Deletion
    func deleteLogs() {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Log")
      let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        backgroundContext.performAndWait {
                try? backgroundContext.execute(deleteRequest)
                try? backgroundContext.save()
        }
    }
}
