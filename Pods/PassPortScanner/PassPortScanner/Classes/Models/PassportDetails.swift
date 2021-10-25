//
//  PassportDetails.swift
//  Scanner
//
//  Created by venusgeo on 16/10/21.
//

import Foundation
import XavierFramework

typealias PassportInformation = [String: String]

struct PassportDetails: Codable {
    
    let countryCode: String?
    let passportNumber: String?
    let personalNumber: String?
    let documentType: String?
    let nationality: String?
    let sex: String?
    let firstName: String?
    let lastName: String?
    var dateOfBirth: String?
    
    var expirationDate: String? {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyMMdd"
        }
    }
    
    init(mrzData: PassportInformation) {
        let pattern = "[^A-Za-z0-9]+"
        self.countryCode = mrzData["countryCode"]
        self.passportNumber = mrzData["passportNumber"]?.replacingOccurrences(of: pattern, with: "", options: [.regularExpression])
        self.personalNumber = mrzData["personalNumber"]?.replacingOccurrences(of: pattern, with: "", options: [.regularExpression])
        self.documentType = mrzData["documentType"]
        self.nationality = mrzData["nationality"]
        self.sex = mrzData["sex"]
        self.firstName = mrzData["firstName"]
        self.lastName = mrzData["lastName"]

        let dateFormatter = DateFormatter()
        let formatterString = "yyMMdd"
        dateFormatter.dateFormat = formatterString
        if let expiration = mrzData["expirationDate"], !expiration.isEmpty {
            if let date = dateFormatter.date(from: expiration) {
                 dateFormatter.dateFormat = "dd-MMMM-yyyy"
                 let dateString = dateFormatter.string(from: date)
                 expirationDate = dateString
            } else {
                expirationDate = ""
            }
        }
        dateFormatter.dateFormat = formatterString
        if let dob = mrzData["dateOfBirth"], !dob.isEmpty {
            if let date = dateFormatter.date(from: dob) {
                 dateFormatter.dateFormat = "dd-MMMM-yyyy"
                 let dateString = dateFormatter.string(from: date)
                dateOfBirth = dateString
            } else {
                dateOfBirth = ""
            }
        }
    }
}
