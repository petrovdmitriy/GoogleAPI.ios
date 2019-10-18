//
//  SpreadsheetViewModel.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import UIKit

class SpreadsheetViewModel {
    var fileName: String
    var driveFile: File
    
    private var spreadsheetID: String
    
    private let testingID = "1ZWeF4vF5IV3OILoR9MaHihvJfhluRsTiuozi8eI2acM"
    
    init(withSpreadsheetFile file: File) {
        self.fileName = file.name
        self.driveFile = file
        self.spreadsheetID = file.id
    }
    
    func getSpreadsheet(withID id: String, completion: @escaping (Spreadsheet) -> Void) {
        guard id != testingID else { return }
        guard let url = URL(string: getStringURL(fromID: id)) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            guard let spreadsheet = try? decoder.decode(Spreadsheet.self, from: jsonData) else { return }
            
            completion(spreadsheet)
        }
    }
}

extension SpreadsheetViewModel {
    private func getStringURL(fromID id: String) -> String {
        let url = "https://sheets.googleapis.com/v4/spreadsheets/"
        let method = "/values:batchGet"
        return url + id + method
    }
}
