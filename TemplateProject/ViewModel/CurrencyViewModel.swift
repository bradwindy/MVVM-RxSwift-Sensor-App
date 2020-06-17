//
//  CurrencyViewModel.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SensingKit

struct CurrencyViewModel {
    weak var sensorService: SensorServiceObservable?

    let input: Input
    let output: Output
    
    let sensingKit = SensingKitLib.shared()
    
    struct Input {
        let reload: PublishRelay<Void>
    }
    
    struct Output {
        let battery: Driver<[Sensor]>
        let errorMessage: Driver<String>
    }
    
    init(currService: CurrencyServiceObservable = FileDataService.shared,
         sensorService: SensorServiceObservable = SensorService.shared) {
        self.sensorService = sensorService
        
        let errorRelay = PublishRelay<String>()
        let reloadRelay = PublishRelay<Void>()
        
        let battery = reloadRelay
            .asObservable()
            .flatMapLatest({
                sensorService.fetchReading()
            })
            .map({ $0 })
            .asDriver { (error) -> Driver<[Sensor]> in
                errorRelay.accept((error as? ErrorResult)?.localizedDescription ?? error.localizedDescription)
                return Driver.just([])
        }

        
        
        self.input = Input(reload: reloadRelay)
        self.output = Output(battery: battery,
                             errorMessage: errorRelay.asDriver(onErrorJustReturn: "An error happened"))
    }
}
