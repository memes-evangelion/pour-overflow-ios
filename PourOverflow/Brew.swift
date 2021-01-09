//
//  Brew.swift
//  PourOverflow
//
//  Created by marto on 09/01/21.
//

import UIKit

class Brew {
    let id: String
    let brewMethod: String
    let coffee: Int // in grams
    let water: Int // in ml
    let brewTime: Int? // in seconds
    let score: Int // 0 - 100 score
    let dateCreated: Date
    
    // Designated initializer.
    init(brewMethod: String, coffee: Int, water: Int, brewTime: Int?, score: Int) {
        self.id = UUID().uuidString
        self.brewMethod = brewMethod
        self.coffee = coffee
        self.water = water
        self.brewTime = brewTime
        self.score = score
        self.dateCreated = Date()
    }

}
