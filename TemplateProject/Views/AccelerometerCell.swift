//
//  AccelerometerCell.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import UIKit

class AccelerometerCell: UITableViewCell {
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var yTitleLabel: UILabel!
    
    var gyro : Gyro? {
        didSet {
            guard let gyro = gyro else { return }
            yLabel.text = String(format: "%.3f", (gyro.z * -9.5493))
        }
    }
}
