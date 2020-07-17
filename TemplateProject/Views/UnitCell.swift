//
//  UnitCell.swift
//  TemplateProject
//
//  Created by Bradley Windybank on 17/07/20.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Foundation
import UIKit

class UnitCell: UICollectionViewCell {
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var amount: String? {
        didSet {
            guard let amount = amount else { return }
            detailLabel.text = amount.formatNumberString()
        }
    }
    
    var unit: String? {
        didSet {
            guard let unit = unit else { return }
            unitLabel.text = unit
        }
    }
    
    var desc: String? {
        didSet {
            guard let desc = desc else { return }
            descriptionLabel.text = desc
        }
    }
}
