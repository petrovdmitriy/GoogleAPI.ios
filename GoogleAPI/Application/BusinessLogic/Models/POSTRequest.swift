//
//  POSTRequest.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

struct POSTRequest: Encodable {
    var valueInputOption = "RAW"
    var data: [POSTData]
}

struct POSTData: Encodable {
    var range: String
    var majorDimension = "ROWS"
    var values: [[String]]
}
