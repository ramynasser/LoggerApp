//
//  LogItem.swift
//  LoggerApp
//
//  Created by Ramy Nasser on 2/26/20.
//  Copyright © 2020 Ramy. All rights reserved.
//

import Foundation

public struct LogItem {
    var log:String
    var date:Date = Date()
}
public enum Level: Int {
    case error,verbose

    var description: String {
        return String(describing: self).uppercased()
    }
}

