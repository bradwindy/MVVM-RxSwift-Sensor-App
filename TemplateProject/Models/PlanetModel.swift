//
//  PlanetModel.swift
//  TemplateProject
//
//  Created by Bradley Windybank on 3/07/20.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct PlanetResponse {
    let count : Int
    let nextUrlString : String
    let prevUrlString: String?
    let results: [Planet]
}

extension PlanetResponse: Parseable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<PlanetResponse, ErrorResult> {
        if let count = dictionary["count"] as? Int,
            let nextUrlString = dictionary["next"] as? String,
            let results = dictionary["results"] as? [[String: AnyObject]] {
            
            var planets: [Planet] = []
            
            for result in results {
                let planetResult = Planet.parseObject(dictionary: result)
                switch planetResult {
                case .success(let planet):
                    planets.append(planet)
                default:
                    break
                }
            }
            
            return .success(PlanetResponse(count: count,
                                           nextUrlString: nextUrlString,
                                           prevUrlString: nil,
                                           results: planets))
        }
        else {
            return .failure(.parser(string: "Unable to parse planet response"))
        }
    }
}

struct Planet {
    let name : String
    let diameter : String
    let rotationPeriod: String
    let orbitalPeriod: String
    let gravity: String
    let population: String
    let climate: String
    let terrain: String
    let surfaceWater: String
    let residents: [String]
    let films: [String]
    let url: String
    let created: String
    let edited: String
}

extension Planet: Parseable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Planet, ErrorResult> {
        if let name = dictionary["name"] as? String,
            let diameter = dictionary["diameter"] as? String,
            let rotationPeriod = dictionary["rotation_period"] as? String,
            let orbitalPeriod = dictionary["orbital_period"] as? String,
            let gravity = dictionary["gravity"] as? String,
            let population = dictionary["population"] as? String,
            let climate = dictionary["climate"] as? String,
            let terrain = dictionary["terrain"] as? String,
            let surfaceWater = dictionary["surface_water"] as? String,
            let residents = dictionary["residents"] as? [String],
            let films = dictionary["films"] as? [String],
            let url = dictionary["url"] as? String,
            let created = dictionary["created"] as? String,
            let edited = dictionary["edited"] as? String {
            
            return .success(Planet(name: name,
                                   diameter: diameter,
                                   rotationPeriod: rotationPeriod,
                                   orbitalPeriod: orbitalPeriod,
                                   gravity: gravity,
                                   population: population,
                                   climate: climate,
                                   terrain: terrain,
                                   surfaceWater: surfaceWater,
                                   residents: residents,
                                   films: films,
                                   url: url,
                                   created: created,
                                   edited: edited))
        }
        else {
            return .failure(.parser(string: "Unable to parse planet"))
        }
    }
}
