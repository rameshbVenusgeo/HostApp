//
//  DocumentListViewModel.swift
//  DocumentScanner
//
//  Created by venusgeo on 22/10/21.
//

import Foundation

public enum ListOfDocuments: String {
    case CovidVaccineCertificate = "Covid Vaccine Certificate"
    case RTPCRNegativeTest = "RT-PCR Negative Test"
    case RTPCRNegativeTestLatest = "RT-PCR Negative Test\nBefore 90 Days"
    case Doc4 = "Dcoument4"
    case Doc5 = "Dcoument5"
    
    func description() -> String {
        return self.rawValue
    }
    
    static let allValues = [CovidVaccineCertificate,
                            RTPCRNegativeTest,
                            RTPCRNegativeTestLatest,
                            Doc4,
                            Doc5]
}

class DocumentListViewModel {
    private var uploadedDocuments: [ListOfDocuments: URL] = [:]
    
    init(covidCertURL: URL) {
        self.uploadedDocuments[.CovidVaccineCertificate] = covidCertURL
    }
    
    func getNoOfDocumentsRequried() -> Int {
        return ListOfDocuments.allValues.count
    }
    
    func getNoOfDocumentsUploaded() -> Int {
        return uploadedDocuments.count
    }
    
    func getListOfDocuments() -> [ListOfDocuments] {
        return ListOfDocuments.allValues
    }
    
    func getDocumentName(index: Int) -> String {
        var description = getListOfDocuments()[index].description()
        if let endOfSentence = description.firstIndex(of: "\n") {
            description = String(description[...endOfSentence])
            description = description.replacingOccurrences(of: "\n", with: "")
        }
        return description
    }
    func getCaptionName(index: Int) -> String? {
        let description = getListOfDocuments()[index].description()
        var caption: String?
        if let endOfSentence = description.firstIndex(of: "\n") {
            caption = String(description[endOfSentence...])
            caption = caption?.replacingOccurrences(of: "\n", with: "")
        }
        return caption
    }
    func getDocumentStatus(index: Int) -> Bool {
        let document = getListOfDocuments()[index]
        return (uploadedDocuments[document] != nil)
    }
    
    func updateDocumentListStatus(documentType: ListOfDocuments, documentUrl: URL) {
        self.uploadedDocuments[documentType] = documentUrl
    }
    
}
