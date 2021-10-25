////
////  GSKLaunchHandler.swift
////  DocumentScanner
////
////  Created by RRR on 20/10/21.
////
//
//import Foundation
//import GSSDKScanFlow
//import GSSDKCore
//import Vision
//import VisionKit
//import PDFKit
//
//protocol GSKLaunchHandlerDelegate: AnyObject {
//    func scanningCompleted(documentUrl: URL)
//    func scanningFailed(error: Error)
//}
//
//class GSKLaunchHandler {
//    private var scanner: GSKScanFlow!
//    private var controller: RootControllerViewController
//    private var delegate: GSKLaunchHandlerDelegate
//    init(key: String, onController: RootControllerViewController, delegate: GSKLaunchHandlerDelegate) {
//        self.controller = onController
//        self.delegate = delegate
//        do {
//            try GSK.initWithLicenseKey(key)
//        } catch {
//            print("Error while initializing the Genius Scan SDK: \(error)")
//            self.delegate.scanningFailed(error: error)
//        }
//    }
//    
//    func launchScanner() {
//         let configuration = baseScannerConfiguration()
//         configuration.source = .camera
//         scan(with: configuration)
//    }
//    
//    func launchLibrary() {
//        let configuration = baseScannerConfiguration()
//        configuration.source = .library
//
//        scan(with: configuration)
//    }
//    
//    private func baseScannerConfiguration() -> GSKScanFlowConfiguration {
//        let configuration = GSKScanFlowConfiguration()
//        configuration.backgroundColor = .white
//        configuration.foregroundColor = .red
//        return configuration;
//    }
//    private func scan(with configuration: GSKScanFlowConfiguration) {
//        scanner = GSKScanFlow(configuration: configuration)
//        scanner.start(from: controller, onSuccess: { [weak self] result in
//
//            print("Here is the PDF file: \(result.pdfURL)")
//            self?.delegate.scanningCompleted(documentUrl: result.pdfURL)
//           
//        }, failure: { [weak self] error in
//            print("An error happened: \(error)")
//            self?.delegate.scanningFailed(error: error)
//        })
//    }
//}
