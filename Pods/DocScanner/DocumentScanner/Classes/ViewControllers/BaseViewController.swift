//
//  BaseViewController.swift
//  DocumentScanner
//
//  Created by venusgeo on 20/10/21.
//

import Foundation
import GSSDKScanFlow
import GSSDKCore

class BaseViewController: RootControllerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try GSK.initWithLicenseKey("533c5006575103020450005439525a0e4a15570a4145555c0d187009544d5d550c403701595b5852176d00045155020651535005")
        } catch {
            /**
             If the SDK is not properly initialized, the SDK method will return errors. This will help you setup the SDK properly. After that, the only reason why this may return an error would be if the license expires.
             All the SDK errors return proper errors in that case and you can handle them to ensure you provide a good "degraded" experience. For instance, you can prompt them to update the application to use the scanning
             feature.
             */
            print("Error while initializing the Genius Scan SDK: \(error)")
        }

    }
    @IBAction func scanVaccineCertificateButtonTapped(_ sender: Any) {
        launchScanner(source: .camera)
    }
    
    @IBAction func uploadVaccineCertificateButtonTapped(_ sender: Any) {
        launchScanner(source: .library)
    }
    func launchScanner(source: GSKScanFlowSource) {
         let configuration = baseScannerConfiguration()
         configuration.source = source
         scan(with: configuration)
    }
    private func baseScannerConfiguration() -> GSKScanFlowConfiguration {
        let configuration = GSKScanFlowConfiguration()
        configuration.multiPage = true
        return configuration
    }
    var scanFlow: GSKScanFlow?
    private func scan(with configuration: GSKScanFlowConfiguration) {
        scanFlow = GSKScanFlow(configuration: configuration)
        scanFlow?.start(from: self, onSuccess: { [weak self] result in
            
            print("Here is the PDF file: \(result.pdfURL)")
            self?.goToDocumentListViewController(pdfUrl: result.pdfURL)
           
        }, failure: { [weak self] error in
            print("An error happened: \(error)")
            let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        })
    }
    
    func goToDocumentListViewController(pdfUrl: URL) {
        DocumentScannerRouter.openDocumentListViewController(covidCertificate: pdfUrl, onController: self)
    }
    
}

//extension BaseViewController: GSKLaunchHandlerDelegate {
//    func scanningCompleted(documentUrl: URL) {
//        let previewController = UIDocumentInteractionController(url: documentUrl)
//        previewController.delegate = self
//        previewController.presentPreview(animated: true)
//    }
//    
//    func scanningFailed(error: Error) {
//        let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    
//}

