//
//  ViewModel.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SensingKit

struct ViewModel {
    weak var accelerometerService: AccelerometerServiceObservable?

    let input: Input
    let output: Output
    
    let sensingKit = SensingKitLib.shared()
    
    struct Input {
        let reload: PublishRelay<Void>
    }
    
    struct Output {
        let accelerometer: Driver<[Accelerometer]>
        let errorMessage: Driver<String>
    }
    
    init(currService: CurrencyServiceObservable = FileDataService.shared,
         accelerometerService: AccelerometerServiceObservable = AccelerometerService.shared) {
        self.accelerometerService = accelerometerService
        
        let errorRelay = PublishRelay<String>()
        let reloadRelay = PublishRelay<Void>()
        
        let accelerometer = reloadRelay
            .asObservable()
            .flatMapLatest({
                accelerometerService.fetchReading()
            })
            .map({ $0 })
            .asDriver { (error) -> Driver<[Accelerometer]> in
                errorRelay.accept((error as? ErrorResult)?.localizedDescription ?? error.localizedDescription)
                return Driver.just([])
        }

        
        
        self.input = Input(reload: reloadRelay)
        self.output = Output(accelerometer: accelerometer,
                             errorMessage: errorRelay.asDriver(onErrorJustReturn: "An error happened"))
    }
}
