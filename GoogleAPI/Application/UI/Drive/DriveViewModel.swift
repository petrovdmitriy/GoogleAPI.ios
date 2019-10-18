//
//  DriveViewModel.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import UIKit
import GoogleSignIn

class DriveViewModel {
    var driveFiles: [File] = []
    
    func getFiles(withToken token: String, completion: @escaping ([File]) -> Void) {
        guard let url = URL(string: getStringURL(withToken: token)) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }
            guard let jsonResponse = response else { return }
            
            let str = jsonData.prettyPrintedJSONString!
            
            let decoder = JSONDecoder()
            guard let fileResponse = try? decoder.decode(FileResponse.self, from: jsonData) else {
                return
            }
            
            completion(fileResponse.files)
        }
        .resume()
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

extension DriveViewModel {
    private func getStringURL(withToken token: String) -> String {
        var url = "https://www.googleapis.com/drive/v3/files/"
        return url + "?access_token=" + token + "&q=mimeType='application/vnd.google-apps.spreadsheet'"
    }
}
