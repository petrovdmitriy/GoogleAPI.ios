//
//  SpreadsheetViewController.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import UIKit

class SpreadsheetViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SpreadsheetViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getFiles()
        
        self.title = viewModel.fileName
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SpreadsheetTableViewCell", bundle: nil), forCellReuseIdentifier: "SpreadsheetTableViewCell")
    }
    
    private func getFiles() {
        viewModel.getSpreadsheet(withID: viewModel.driveFile.id, withToken: GoogleService.accessToken) { sheet in
            guard let sheet = sheet else { return }
            self.viewModel.sheet = sheet
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension SpreadsheetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sheet?.values.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SpreadsheetTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SpreadsheetTableViewCell else {
            fatalError()
        }
        let sheet = viewModel.sheet?.values[indexPath.row]
        
        if indexPath.row == 0 {
            cell.backgroundColor = .lightGray
        }
        
        cell.nameLabel.text = sheet?[0]
        cell.priceLabel.text = sheet?[1]
        cell.dateLabel.text = sheet?[2]
        
        return cell
    }
}

extension SpreadsheetViewController: UITableViewDelegate {
}
