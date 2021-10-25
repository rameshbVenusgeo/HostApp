//
//  ThreadCheck.swift
//  PassPortScanner
//
//  Created by venusgeo on 24/10/21.
//

import Foundation

typealias Mainblock = () -> Void

func ensureOnMainQueue(completionBlock: @escaping Mainblock) {
    if OperationQueue.current == OperationQueue.main {
        completionBlock()
    } else {
        OperationQueue.main.addOperation {
            completionBlock()
        }
    }
}
