//
//  DataBaseDestination.swift
//  LoggerApp
//
//  Created by Ramy Nasser on 2/26/20.
//  Copyright © 2020 Ramy. All rights reserved.
//

import Foundation
class DatabaseStorage: Storage {
     var coreDataManager : LogsDataManager = LogsDataManager()

    init(coreDataManager:LogsDataManager = LogsDataManager()) {
        self.coreDataManager = coreDataManager
    }
    func saveLog(logItem: LogItem) {
        coreDataManager.createLog(log: logItem)
    }
    func getLogs() -> [LogItem] {
        var items: [LogItem] = []
        let records = coreDataManager.fetchRecords()
        for record in records {
            let log = record.value(forKey: "content") as! String
            let date = record.value(forKey: "createdAt") as! Date
            items.append(LogItem(log: log, date: date))
        }
        
        return items
    }
    
    func deleteLogs() {
        coreDataManager.deleteLogs()
    }
    
    
}
