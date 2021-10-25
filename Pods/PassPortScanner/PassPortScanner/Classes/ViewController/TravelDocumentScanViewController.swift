//
//  TravelDocumentScanViewController.swift
//  Scanner
//
//  Created by venusgeo on 02/10/21.
//

import Foundation
import XavierFramework


class TravelDocumentScanViewController: UITableViewController, UINavigationControllerDelegate {
    
    var parsedMRZ = ParsedMRZ()
    
    override func viewDidLoad() {
        
    }
}

/*

class TravelDocumentScanViewController: PassportScannerController, UINavigationControllerDelegate {
    var delegate: ProcessMRZ?
    
    override func viewDidLoad() {

        self.showPostProcessingFilters = false
        self.debug = true // So that we can see what's going on (scan text and quality indicator)
        self.mrzType = .auto // Performs a little better when set to td1 or td3
        self.StartScan(sender: self)
        let closeButton = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: 50, height: 30))
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        self.view.addSubview(closeButton)
        self.view.bringSubviewToFront(closeButton)
      //  launchXavier()
    }
    
  /*  @objc func launchXavier() {
        let mrzScanner = MRZScanner()
        mrzScanner.start(self, licenseKey: "$2a$12$4fRrp695mahasvBWSSBLtOX/OMHxS5qmI0dweFc9pBMTx0P.SChaG")
    } */
    
    @objc func closeButtonTapped() {
        self.StopScan(sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get { return .portrait }
    }
    override func successfulScan(mrz: MRZParser) {
        print("mrz: {\(mrz.description)\n}")
        self.dismiss(animated: true, completion: nil)
        delegate?.processMRZ(mrz: mrz)
    }
    
    override func abortScan() {
        self.dismiss(animated: true, completion: nil)
    }
}

*/
