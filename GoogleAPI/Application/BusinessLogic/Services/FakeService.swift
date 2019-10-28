//
//  FakeService.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 18/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import Fakery

class Mocker {
    var faker: Faker!
    
    init() {
        self.faker = Faker(locale: "nb-NO")
    }
    
    var name: String {
        return faker.company.name()
    }
    
    var price: String {
        return String(faker.commerce.price())
    }
    
    var purchaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let date = faker.date.birthday(0, 1)
        
        let purchaseDate = dateFormatter.string(from: date)
        return purchaseDate
    }

}
