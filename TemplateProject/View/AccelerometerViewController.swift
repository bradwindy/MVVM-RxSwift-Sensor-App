//
//  AccelerometerViewController.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 12/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AccelerometerViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    let viewModel = ViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Device Orientation Value"
        self.bindViews()
    }
    
    private func bindViews() {
        // bind data to tableview
        self.viewModel.output.accelerometer.drive(
            self.tableView.rx.items(cellIdentifier: "AccelerometerCell",
                                    cellType: AccelerometerCell.self)) { (row, sensor, cell) in
                                        
                                        cell.accelerometer = sensor
                                        
        }.disposed(by: disposeBag)
        
        self.viewModel.output.errorMessage
            .drive(onNext: { [weak self] errorMessage in
                guard let strongSelf = self else { return }
                
                strongSelf.showError(errorMessage)
                
            }).disposed(by: disposeBag)
        
        // Reloads viewModel with void event as it is the initial load
        self.viewModel.input.reload.accept(())
    }
    
    private func showError(_ errorMessage: String) {
        let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}
