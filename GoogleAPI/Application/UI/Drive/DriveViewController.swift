//
//  DriveViewController.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import UIKit

class DriveViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var googleSignOutButton: UIButton!
    
    private let viewModel = DriveViewModel()
    private let googleService = GoogleService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = 65
        tableView.register(UINib(nibName: "DriveTableViewCell", bundle: nil), forCellReuseIdentifier: "DriveTableViewCell")
        
        viewModel.getFiles(withToken: GoogleService.accessToken) { files in
            let files = files
            self.viewModel.driveFiles = files
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        googleSignOutButton.layer.masksToBounds = true
        googleSignOutButton.layer.cornerRadius = 6.0
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any?) {
        googleService.signOut()
    }
}

extension DriveViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.driveFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DriveTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DriveTableViewCell else {
            fatalError()
        }
        let file = viewModel.driveFiles[indexPath.row]
        
        cell.nameLabel.text = file.name
        
        return cell
    }
}
