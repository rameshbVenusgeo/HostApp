//
//  BaseViewController.swift
//  PassPortScanner
//
//  Created by venusgeo on 02/10/21.
//

import UIKit
import XavierFramework

class BaseViewController: UIViewController {
        
    var selectedScannerType: ScannerType?

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var scanPassPortButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        scanPassPortButton.addTarget(self, action: #selector(launchXavier), for: .touchUpInside)
    }
    
    private func commonInit() {
        guard let scanType = selectedScannerType else { return }
        
        switch scanType {
        case .Passport:
            hintLabel.attributedText = NSAttributedString(string: "2) Ensure that you are able to clearly see the passport bio page")
            scanPassPortButton.setTitle("Scan Passport", for: .normal)
        case .Visa:
            hintLabel.attributedText = NSAttributedString(string: "2) Ensure that you are able to clearly see the visa page")
            scanPassPortButton.setTitle("Scan Visa", for: .normal)
        }
    }
}

// MARK:- Private helpers
extension BaseViewController: XavierScannerDelegate {
    private func presentScanner() {
        let viewController = TravelDocumentScanViewController()
         viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc private func launchXavier() {
        ensureOnMainQueue {
            let mrzScanner = MRZScanner()
            mrzScanner.flashOffButtonColor = .white
            mrzScanner.start(self, licenseKey: Constants.xavierLicenceKey)
        }
    }
    
    // MARK: XavierDelegate Functions
    func handleResults(results: ParsedMRZ) {
        guard let viewController: PassportDetailsViewController = UIStoryboard(name: "PassPortScanner", bundle: Bundle.passportScannerBundle()).instantiateViewController(withIdentifier: "PassportDetailsViewController") as? PassportDetailsViewController else { return }
        viewController.parsedMRZ = results
        viewController.modalPresentationStyle = .fullScreen
        ensureOnMainQueue {
            self.present(viewController, animated: false, completion: nil)
        }
    }
    
    func scanCancelled() {
        print("scan cancelled")
    }
}
