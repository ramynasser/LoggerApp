//
//  ViewController.swift
//  LoggerApp
//
//  Created by Ramy Nasser on 7/15/20.
//  Copyright © 2020 Ramy Nasser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let log = Logger.shared
    private let queue = DispatchQueue(label: "com.test.log",attributes: .concurrent)

    private let queue2 = DispatchQueue(label: "com.test.log",attributes: .concurrent)

    override func viewDidLoad() {
        super.viewDidLoad()
        log.setup(formatter: .default,minLevel: .error)
        log.logItem("this is error in viewDidLoad", level: .verbose)
        queue.async { [weak self] in
            self?.log.logItem("this is error in queue", level: .error)

        }
        queue.async { [weak self] in
            self?.log.logItem("this is error in queue", level: .error)

        }
        queue2.async { [weak self] in
            self?.log.logItem("this is error in queue2", level: .error)

        }
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.log.logItem("this is error in background queue", level: .error)
        }
        DispatchQueue.main.async { [weak self] in
            self?.log.logItem("this is error in main queue", level: .error)
        }
        // Do any additional setup after loading the view.
    }
    
    

    
    override func viewDidAppear(_ animated: Bool) {
        for item in log.fetchLogs() {
            print(item.log)
        }
    }

}



