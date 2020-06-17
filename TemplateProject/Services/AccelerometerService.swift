//
//  AccelerometerService.swift
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

protocol AccelerometerServiceObservable: class {
    func fetchReading() -> Observable<[Accelerometer]>
}

final class AccelerometerService: AccelerometerServiceObservable {
    static let shared = AccelerometerService()
    let coreMotionManager = CMMotionManager.rx.manager()
    
    func fetchReading() -> Observable<[Accelerometer]> {
        return coreMotionManager
            .flatMapLatest { manager in
                manager.acceleration ?? Observable.empty()
        }
        .observeOn(MainScheduler.instance)
//        .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
        .map({ [Accelerometer(x: $0.x, y: $0.y, z: $0.z)] })
    }
}
