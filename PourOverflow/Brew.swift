//
//  Brew.swift
//  PourOverflow
//
//  Created by marto on 09/01/21.
//

import UIKit

enum BrewMethod: CaseIterable {
    case Switch, AeroPress, v60, KalitaWave, Chemex, Espresso
}

enum GrainMethod: CaseIterable {
    case Lavado, Honey, Natural
}

struct Brew {
    let id: UUID
    let brewMethod: BrewMethod
    let grains: GrainMethod?
    let coffee: Int // in grams
    let water: Int // in ml
    let duration: Measurement<UnitDuration>? // in seconds
    let score: Int // 0 - 100 score
    let creationDate: Date
    
    init(brewMethod: BrewMethod, grains: GrainMethod?, coffee: Int, water: Int, duration: Measurement<UnitDuration>?, score: Int, creationDate: Date) {
        self.id = UUID()
        self.brewMethod = brewMethod
        self.grains = grains
        self.coffee = coffee
        self.water = water
        self.duration = duration
        self.score = score
        self.creationDate = creationDate
    }
    
    static func createRandomBrew() -> Brew {
        let randomMethod = BrewMethod.allCases.randomElement()!
        let randomGrains = GrainMethod.allCases.randomElement()!
        
        let randomCoffee = Int.random(in: 10...30)
        let randomWater = Int.random(in: 100...300)
        
        let randomSeconds = Double.random(in: 20...400)
        let randomDuration = Measurement(value:randomSeconds, unit: UnitDuration.seconds)
        
        let randomScore = Int.random(in: 0...100)
        
        let previousDays = Int.random(in: 1...120)
        let randomCreationDate = Calendar.current.date(byAdding: .day, value: -previousDays, to: Date())!

        
        return self.init(brewMethod: randomMethod, grains: randomGrains, coffee: randomCoffee, water: randomWater, duration: randomDuration, score: randomScore, creationDate: randomCreationDate)
    }
}
