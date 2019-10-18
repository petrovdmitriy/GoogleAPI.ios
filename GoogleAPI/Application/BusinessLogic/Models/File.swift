//
//  DriveFile.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

struct FileResponse: Decodable {
    var kind: String
    var files: [File]
}

struct File: Decodable {
    var mimeType: String
    var id: String
    var kind: String
    var name: String
}
