//
//  PlanetTableViewController.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 12/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class DetailScreenViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    // Force unwrapped as I will always set this after instatiating VC
    var viewModel: DetailScreenViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViews()
    }
    
    private func bindViews() {
        self.viewModel.output.properties.drive(
            self.collectionView.rx.items(cellIdentifier: "UnitCell",
                                    cellType: UnitCell.self)) { (index, property, cell) in
                                        
                                        cell.amount = property.detail
                                        cell.unit = property.unit
                                        cell.desc = property.description
                                        
                                        
        }.disposed(by: disposeBag)
        
        self.viewModel.output.errorMessage.drive(onNext: { [weak self] errorMessage in
            guard let self = self else { return }
            self.showError(errorMessage)
        }).disposed(by: disposeBag)
        
        // Reloads viewModel with void event as it is the initial load
        self.viewModel.input.reload.accept(())
    }
    
    private func showError(_ errorMessage: String) {
        let controller = UIAlertController(title: "An error occured", message: errorMessage, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}
