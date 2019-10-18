//
//  DriveFile.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

struct DriveFileResponse: Decodable {
    var kind: String
    var files: [DriveFile]
}

struct DriveFile: Decodable {
    var id: String
    var kind: String
    var mimeType: String
    var name: String
}
