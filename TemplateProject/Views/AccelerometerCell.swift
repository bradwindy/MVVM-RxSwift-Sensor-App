//
//  AccelerometerCell.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import UIKit

class AccelerometerCell: UITableViewCell {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    @IBOutlet weak var xTitleLabel: UILabel!
    @IBOutlet weak var yTitleLabel: UILabel!
    @IBOutlet weak var zTitleLabel: UILabel!
    
    var accelerometer : Accelerometer? {
        didSet {
            guard let accelerometer = accelerometer else { return }
            
            xLabel.text = String(format: "%.1f", accelerometer.x)
            yLabel.text = String(format: "%.1f", accelerometer.y)
            zLabel.text = String(format: "%.1f", accelerometer.z)
        }
    }
}
