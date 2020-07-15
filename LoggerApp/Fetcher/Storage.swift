//
//  Destination.swift
//  LoggerApp
//
//  Created by Ramy Nasser on 2/26/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import Foundation
public protocol Storage {
    func saveLog(logItem:LogItem)
    func getLogs()->[LogItem]
    func deleteLogs()
}
