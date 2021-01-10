//
//  Brew.swift
//  PourOverflow
//
//  Created by marto on 09/01/21.
//

import UIKit

// Use class when pointerA === pointerB
// Default to struct instead of class
struct Brew {
    let id: UUID
    let brewMethod: String
    let coffee: Int // in grams
    let water: Int // in ml
    let duration: UnitDuration? // in seconds
    let score: Int // 0 - 100 score
    let creationDate: Date
    
    // Designated initializer.
    init(brewMethod: String, coffee: Int, water: Int, duration: UnitDuration?, score: Int) {
        self.id = UUID()
        self.brewMethod = brewMethod
        self.coffee = coffee
        self.water = water
        self.duration = duration
        self.score = score
        self.creationDate = Date()
    }

}
