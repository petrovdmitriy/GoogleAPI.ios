//
//  SpreadsheetViewController.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import UIKit

class SpreadsheetViewController: UIViewController {
    
    var viewModel: SpreadsheetViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.fileName
    }
}
