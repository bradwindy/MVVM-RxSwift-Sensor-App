//
//  DetailScreenViewModel.swift
//  TemplateProject
//
//  Created by Bradley Windybank on 10/07/20.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct DetailScreenViewModel {
    let input: Input
    let output: Output
    
    struct Input {
        let reload: PublishRelay<Void>
    }
    
    struct Output {
        let planet: Driver<Planet?>
        let errorMessage: Driver<String>
    }
    
    init(planet: Planet) {
        let errorRelay = PublishRelay<String>()
        let reloadRelay = PublishRelay<Void>()
        
        let planetDriver = reloadRelay
            .map({ planet })
            .asDriver { (error) -> Driver<Planet?> in
                errorRelay.accept((error as? ErrorResult)?.localizedDescription ?? error.localizedDescription)
                return Driver.just(nil)
        }
        
        self.input = Input(reload: reloadRelay)
        self.output = Output(planet: planetDriver,
                             errorMessage: errorRelay.asDriver(onErrorJustReturn: "An error happened"))
    }
}
