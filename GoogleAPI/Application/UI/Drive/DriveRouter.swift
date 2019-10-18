//
//  DriveRouter.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import UIKit

enum DriveRouterPath {
    case spreadsheet(fromFile: File)
}

extension DriveRouterPath: RouterPath {
    var vcToRoute: UIViewController? {
        switch self {
        case let .spreadsheet(file):
            let vc = SpreadsheetViewController.initFromNib()
            vc.viewModel = SpreadsheetViewModel(withSpreadsheetFile: file)
            return vc
        }
    }
}
