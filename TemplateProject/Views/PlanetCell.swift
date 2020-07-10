//
//  AccelerometerCell.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import UIKit

class PlanetCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rotationLabel: UILabel!
    @IBOutlet weak var orbitLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    
    var planet: Planet? {
        didSet {
            guard let planet = planet else { return }
            titleLabel.text = planet.name
            rotationLabel.text = planet.rotationPeriod
            orbitLabel.text = planet.orbitalPeriod
            diameterLabel.text = formatLongNumString(planet.diameter)
        }
    }
    
    private func formatLongNumString(_ string: String) -> String {
        if let stringInt = Int(string) {
            return formatNumberAsBMK(stringInt)
        }
        else {
            return "N/A"
        }
    }
    
    private func formatNumberAsBMK(_ n: Int) -> String {

        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""

        switch num {
            
        case 1_000_000_000_000...:
            var formatted = num / 1_000_000_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)T"

        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(n)"

        default:
            return "\(sign)\(n)"

        }
    }
}

fileprivate extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
