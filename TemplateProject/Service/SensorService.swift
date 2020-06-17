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
import CoreMotion
import RxCoreMotion

protocol SensorServiceObservable: class {
    func fetchReading() -> Observable<[Sensor]>
}

final class SensorService: RequestHandler, SensorServiceObservable {
    static let shared = SensorService()
    let coreMotionManager = CMMotionManager.rx.manager()
    
    func fetchReading() -> Observable<[Sensor]> {
        return coreMotionManager
        .flatMapLatest { manager in
            manager.acceleration ?? Observable.empty()
        }
        .observeOn(MainScheduler.instance)
        .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
        .map({ [Sensor(
            info: [String(format: "%.2f", $0.x),
                   String(format: "%.2f", $0.y),
                   String(format: "%.2f", $0.z)]
            .joined(separator: ", "))]
        })
    }
}
