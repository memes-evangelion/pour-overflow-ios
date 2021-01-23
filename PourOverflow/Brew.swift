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

enum CoffeeValuation: String, CaseIterable {
    case Horrible = "🤮"
    case Bad = "☹️"
    case Neutral = "😐"
    case Good = "🙂"
    case Amazing = "🤩"
}


struct Brew {
    let id: UUID
    let brewMethod: BrewMethod
    let grains: GrainMethod?
    let coffee: Int // in grams
    let water: Int // in ml
    let duration: Measurement<UnitDuration>? // in seconds
    let creationDate: Date
    let valuation: CoffeeValuation?
    
    init(brewMethod: BrewMethod, grains: GrainMethod?, coffee: Int, water: Int, duration: Measurement<UnitDuration>?, valuation: CoffeeValuation?, creationDate: Date) {
        self.id = UUID()
        self.brewMethod = brewMethod
        self.grains = grains
        self.coffee = coffee
        self.water = water
        self.duration = duration
        self.valuation = valuation
        self.creationDate = creationDate
    }
}
