//
//  DocumentScannerRouter.swift
//  DocumentScanner
//
//  Created by venusgeo on 22/10/21.
//

import Foundation

struct DocumentScannerRouter {
    static func openDocumentListViewController(covidCertificate: URL, onController: UIViewController) {
        if let controller = DocumentListViewController.instantiate(with: covidCertificate) {
            controller.modalPresentationStyle = .fullScreen
            onController.present(controller, animated: true, completion: nil)
        }
    }
}
