//
//  FileDestination.swift
//  LoggerApp
//
//  Created by Ramy Nasser on 2/26/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import Foundation
import Foundation
 class FileStorage: Storage {
    let pattern = "{\(UUID().uuidString)}"

    var fileURL:URL = {
        let fileName = "Logs"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
    }()
     func saveLog(logItem: LogItem) {
        do {
            // Write to the file
            var write = getFileData()
            write.append(logItem.log)
            write.append(pattern)
        
            try write.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }
    
     func getLogs() -> [LogItem] {
        let readString = getFileData()
       
        let logs = readString.components(separatedBy: pattern).filter{$0 != ""}
        return logs.map {return LogItem(log: $0)}
    }
    
    private func getFileData() ->String {
        var readString = ""
              do {
                         // Read the file contents
                         readString = try String(contentsOf: fileURL)
                     } catch let error as NSError {
                         print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
             }
        return readString
    }
     func deleteLogs() {
        do {
                   // Write to the file
                   try "".write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
               } catch let error as NSError {
                   print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
               }
    }
    
    
}

