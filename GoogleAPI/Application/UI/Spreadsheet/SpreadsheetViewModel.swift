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
    var sheet: Sheet?
    
    private var spreadsheetID: String
    
    private let mocker = Mocker()
    private let testingID = "1ZWeF4vF5IV3OILoR9MaHihvJfhluRsTiuozi8eI2acM"
    
    init(withSpreadsheetFile file: File) {
        self.fileName = file.name
        self.driveFile = file
        self.spreadsheetID = file.id
    }
    
    func getSpreadsheet(withID id: String,
                        withToken token: String,
                        completion: @escaping (Sheet?) -> Void) {
        guard let url = URL(string: getStringURL(fromID: id, withToken: token)) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            guard let spreadsheet = try? decoder.decode(Spreadsheet.self, from: jsonData) else { return }
            
            completion(spreadsheet.valueRanges.first)
        }
        .resume()
    }
    
    func postNewRow(withID id: String,
                    withToken token: String,
                    completion: @escaping (URLResponse) -> Void) {
        getParameters(withID: id, withToken: token) { parameteres in
            guard let url = URL(string: self.getStringURLForPOST(fromID: id, withToken: token)) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = parameteres
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else { return }
                guard let response = response else { return }
                
                completion(response)
            }.resume()
        }
    }
}

extension SpreadsheetViewModel {
    private func getParameters(withID id: String,
                               withToken token: String,
                               completion: @escaping (Data) -> Void) {
        getRange(withID: id, withToken: token) { range in
            let name = self.mocker.name
            let price = self.mocker.price
            let date = self.mocker.purchaseDate
            
            let postData = POSTData(range: range, values: [[name, price, date]])
            let postRequest = POSTRequest(data: [postData])
            
            let encoder = JSONEncoder()
            guard let data = try? encoder.encode(postRequest) else {
                return
            }
            
            completion(data)
        }
    }
    
    private func getRange(withID id: String,
                          withToken token: String,
                          completion: @escaping (String) -> Void) {
        getSpreadsheet(withID: id, withToken: token) { sheet in
            guard let rows = sheet?.values.count else { return }
            
            let range = String("A\(rows):C\(rows)")
            
            completion(range)
        }
    }
    
    private func getStringURL(fromID id: String, withToken token: String) -> String {
        var url = "https://sheets.googleapis.com/v4/spreadsheets/"
        url += id + "/values:batchGet/" + "?access_token=" + token + "&ranges=A1:C&majorDimension=ROWS"
        return url
    }
    
    private func getStringURLForPOST(fromID id: String, withToken token: String) -> String {
        var url = "https://sheets.googleapis.com/v4/spreadsheets/"
        url += id + "/values:batchUpdate/?access_token=" + token
        return url
    }
}
