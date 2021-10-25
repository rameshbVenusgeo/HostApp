//
//  PassportDetailsViewController.swift
//  Scanner
//
//  Created by venusgeo on 02/10/21.
//

import UIKit
import XavierFramework

class PassportDetailsViewController: UIViewController {
    
    var parsedMRZ = ParsedMRZ()
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var coutryOfIssueLabel: UILabel!
    @IBOutlet weak var expiratioinDateLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var documentTypeLabel: UILabel!
    @IBOutlet weak var documentNumberLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var givenNameLabel: UILabel!
    @IBOutlet weak var surNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if parsedMRZ == nil {
            ensureOnMainQueue {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            bindDataWithUI()
        }
    }
    
    private func bindDataWithUI() {
        profilePhotoImageView.image = parsedMRZ.documentImage
        surNameLabel.text = parsedMRZ.surname
        givenNameLabel.text = parsedMRZ.givenName
        genderLabel.text = parsedMRZ.sex == "F" ? "Female" : "Male"
        documentNumberLabel.text = parsedMRZ.documentNumber
        documentTypeLabel.text = parsedMRZ.documentType == "P" ? "Passport" : "Visa"
        nationalityLabel.text = parsedMRZ.countryCitizen
        print("dob: \(parsedMRZ.dateBirthCheckDigit)")
        dateOfBirthLabel.text = formattedDateFromString(dateString: parsedMRZ.dateBirth)
        coutryOfIssueLabel.text = parsedMRZ.countryIssue
        expiratioinDateLabel.text = formattedDateFromString(dateString: parsedMRZ.dateExpiration)
        print("exipiration: \(parsedMRZ.dateExpirationCheckDigit)")
    }
    
    func formattedDateFromString(dateString: String) -> String? {

        var formattedDateString = ""
        let dateFormatter = DateFormatter()
        let formatterString = "yyMMdd"
        dateFormatter.dateFormat = formatterString
        let dateExpiration = dateString
        if !dateExpiration.isEmpty {
            if let date = dateFormatter.date(from: dateExpiration) {
                dateFormatter.dateFormat = "dd-MMMM-yy"
                let dateString = dateFormatter.string(from: date)
                formattedDateString = dateString
            }
        }

        return formattedDateString
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
