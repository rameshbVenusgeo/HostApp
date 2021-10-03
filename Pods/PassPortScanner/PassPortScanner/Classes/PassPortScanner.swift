//
//  PassPortScanner.swift
//  PassPortScanner
//
//  Created by venusgeo on 02/10/21.
//

import Foundation

public class PassPortScanner {
    public init() {
        
    }
    
    public func getRootViewController() -> UIViewController? {
        guard let viewController: BaseViewController = UIStoryboard(name: "PassPortScanner", bundle: Bundle.passportScannerBundle()).instantiateInitialViewController() as? BaseViewController else { return nil }
        return viewController
    }
}

extension Bundle {
    static func passportScannerBundle() -> Bundle? {
        let bundle = Bundle(for: PassPortScanner.self)
        guard let url = bundle.url(forResource: "PassPortScanner", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
