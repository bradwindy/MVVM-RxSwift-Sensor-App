//
//  SensorService.swift
//  TemplateProject
//
//  Created by Bradley Windybank on 17/06/20.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SensingKit

protocol SensorServiceObservable: class {
    func fetchReading() -> Observable<[Sensor]>
}

final class SensorService: RequestHandler, SensorServiceObservable {
    static let shared = SensorService()
    let sensingKit = SensingKitLib.shared()
    
    func fetchReading() -> Observable<[Sensor]> {
        return NotificationCenter.default.rx.notification(.UIDeviceOrientationDidChange)
            .observeOn(MainScheduler.instance).map({ _ in [Sensor(info: String(UIDevice.current.orientation.rawValue))]})
    }
}
