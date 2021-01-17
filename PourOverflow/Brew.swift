//
//  Brew.swift
//  PourOverflow
//
//  Created by marto on 09/01/21.
//

import UIKit

enum BrewMethod: CaseIterable {
    case Switch, AeroPress, v60, KalitaWave, Chemex
}

enum GrainMethod: CaseIterable {
    case Lavado, Honey, Natural
}
// Use class when pointerA === pointerB
// Default to struct instead of class
struct Brew {
    let id: UUID
    let brewMethod: BrewMethod
    let grains: GrainMethod?
    let coffee: Int // in grams
    let water: Int // in ml
    let duration: UnitDuration? // in seconds
    let score: Int // 0 - 100 score
    let creationDate: Date
    
    // Designated initializer.
    init(brewMethod: BrewMethod, grains: GrainMethod?, coffee: Int, water: Int, duration: UnitDuration?, score: Int) {
        self.id = UUID()
        self.brewMethod = brewMethod
        self.grains = grains
        self.coffee = coffee
        self.water = water
        self.duration = duration
        self.score = score
        self.creationDate = Date()
    }
    
    static func createRandomBrew() -> Brew {
        let randomMethod = BrewMethod.allCases.randomElement()!
        let randomGrains = GrainMethod.allCases.randomElement()!
        
        let randomCoffee = Int.random(in: 10...30)
        let randomWater = Int.random(in: 100...300)
        
        let randomSeconds = Int.random(in: 30...540)
        let randomDuration = UnitDuration(symbol: "\(randomSeconds) seconds")
        let randomScore = Int.random(in: 0...100)
        
        return self.init(brewMethod: randomMethod, grains: randomGrains, coffee: randomCoffee, water: randomWater, duration: randomDuration, score: randomScore)
    }
}
