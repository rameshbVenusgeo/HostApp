//
//  PassPortScanner.swift
//  PassPortScanner
//
//  Created by venusgeo on 02/10/21.
//

import Foundation

public enum ScannerType {
    case Passport
    case Visa
}

public class PassPortScanner {
    
    public init() {
        
    }
    
    public func getRootViewController(scannerType: ScannerType) -> UIViewController? {
        guard let viewController: BaseViewController = UIStoryboard(name: "PassPortScanner", bundle: Bundle.passportScannerBundle()).instantiateInitialViewController() as? BaseViewController else { return nil }
        viewController.selectedScannerType = scannerType
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
