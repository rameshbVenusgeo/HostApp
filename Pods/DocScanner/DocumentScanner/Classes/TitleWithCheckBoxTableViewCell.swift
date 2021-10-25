//
//  TitleWithCheckBoxTableViewCell.swift
//  DocumentScanner
//
//  Created by venusgeo on 22/10/21.
//

import UIKit

class TitleWithCheckBoxTableViewCell: UITableViewCell {
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var captionStackVIew: UIStackView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configureCell(title: String, caption: String?, status: Bool) {
        self.titleLabel.text = title
        if let captionText = caption {
            captionStackVIew.isHidden = false
            captionLabel.text = captionText
            captionLabel.textColor = .black
        } else {
            captionStackVIew.isHidden = true
        }
        if status {
            checkBox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            checkBox.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
}
