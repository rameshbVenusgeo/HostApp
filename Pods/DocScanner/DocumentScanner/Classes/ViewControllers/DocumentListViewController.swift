//
//  DocumentListViewController.swift
//  DocumentScanner
//
//  Created by venusgeo on 22/10/21.
//

import UIKit
import GSSDKScanFlow
import GSSDKCore

class DocumentListViewController: UIViewController {
    @IBOutlet weak var scanNextButton: UIButton!
    @IBOutlet weak var documentListTableView: UITableView!
    private var viewModel: DocumentListViewModel?
    @IBOutlet weak var documentNumberLabel: UILabel!
    var scanFlow: GSKScanFlow?
    
    static func instantiate(with covidCertURL: URL) -> DocumentListViewController? {
        let vc = UIStoryboard(name: "DocumentScanner", bundle: Bundle.documentScannerBundle()).instantiateViewController(withIdentifier: "DocumentListViewController") as? DocumentListViewController
        vc?.viewModel = DocumentListViewModel.init(covidCertURL: covidCertURL)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDocumentNumberCount()
    }
    func configureTableView() {
        documentListTableView.delegate = self
        documentListTableView.dataSource = self
        documentListTableView.estimatedRowHeight = UITableView.automaticDimension
        documentListTableView.register(UINib.init(nibName: "TitleWithCheckBoxTableViewCell", bundle: Bundle.documentScannerBundle()), forCellReuseIdentifier: "TitleWithCheckBoxTableViewCell")
    }
    
    @IBAction func scanNextButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.launchScanner()
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
    }
    func updateDocumentNumberCount() {
        if let count = viewModel?.getNoOfDocumentsUploaded(),
           let total = viewModel?.getNoOfDocumentsRequried() {
            self.documentNumberLabel.text = "(\(count)/\(total))"
        }
    }
    func launchScanner() {
         let configuration = baseScannerConfiguration()
        configuration.source = .camera
         scan(with: configuration)
    }
    private func baseScannerConfiguration() -> GSKScanFlowConfiguration {
        let configuration = GSKScanFlowConfiguration()
        configuration.multiPage = true
        return configuration
    }
    
    private func scan(with configuration: GSKScanFlowConfiguration) {
        scanFlow = GSKScanFlow(configuration: configuration)
        scanFlow?.start(from: self, onSuccess: { [weak self] result in
            print("Here is the PDF file: \(result.pdfURL)")
            if let documentsUploaded = self?.viewModel?.getNoOfDocumentsUploaded(),
               let nextDocument = self?.viewModel?.getListOfDocuments()[documentsUploaded] {
                self?.viewModel?.updateDocumentListStatus(documentType: nextDocument, documentUrl: result.pdfURL)
            }
            DispatchQueue.main.async { [weak self] in
                self?.documentListTableView.reloadData()
                self?.updateDocumentNumberCount()
                let totalDocs = self?.viewModel?.getNoOfDocumentsRequried()
                let uploadedDocs = self?.viewModel?.getNoOfDocumentsUploaded()
                if totalDocs == uploadedDocs {
                    self?.scanNextButton.isEnabled = false
                }
            }
        }, failure: { [weak self] error in
            print("An error happened: \(error)")
            let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        })
    }
}

extension DocumentListViewController: UITableViewDelegate {
    
}

extension DocumentListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getNoOfDocumentsRequried() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleWithCheckBoxTableViewCell", for: indexPath) as? TitleWithCheckBoxTableViewCell
        let title = viewModel?.getDocumentName(index: indexPath.row) ?? ""
        let caption = viewModel?.getCaptionName(index: indexPath.row)
        let status = viewModel?.getDocumentStatus(index: indexPath.row) ?? false
        cell?.configureCell(title: title, caption: caption, status: status)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
