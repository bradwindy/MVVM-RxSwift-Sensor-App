//
//  GyroService.swift
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

protocol GyroServiceObservable: class {
    func fetchReading() -> Observable<[Gyro]>
}

final class GyroService: GyroServiceObservable {
    static let shared = GyroService()
    let coreMotionManager = CMMotionManager.rx.manager()
    
    func fetchReading() -> Observable<[Gyro]> {
        return coreMotionManager
            .flatMapLatest { manager in
                // TODO: Manager has a heading value that could be used to keep title level
                manager.rotationRate ?? Observable.empty()
        }
        .observeOn(MainScheduler.instance)
//        .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
        .map({ [Gyro(x: $0.x, y: $0.y, z: $0.z)] })
    }
}
