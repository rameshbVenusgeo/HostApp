//
//  DocumentScanner.swift
//  DocumentScanner
//
//  Created by venusgeo on 20/10/21.
//

import Foundation

public class DocumentScanner {
    public init() {
        
    }
    
    public func getRootViewController() -> UIViewController? {
        guard let viewController: BaseViewController = UIStoryboard(name: "DocumentScanner", bundle: Bundle.documentScannerBundle()).instantiateInitialViewController() as? BaseViewController else { return nil }
        return viewController
    }
}

extension Bundle {
    static func documentScannerBundle() -> Bundle? {
        let bundle = Bundle(for: DocumentScanner.self)
        guard let url = bundle.url(forResource: "DocumentScanner", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
