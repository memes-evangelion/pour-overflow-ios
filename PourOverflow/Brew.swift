//
//  Brew.swift
//  PourOverflow
//
//  Created by marto on 09/01/21.
//

import UIKit

enum BrewMethod: CaseIterable {
    case harioSwitch, aeroPress, v60, kalitaWave, chemex, espresso
}

enum GrainMethod: CaseIterable {
    case lavado, honey, natural
}

enum CoffeeValuation: String, CaseIterable {
    case Horrible = "🤮"
    case Bad = "☹️"
    case Neutral = "😐"
    case Good = "🙂"
    case Amazing = "🤩"
}


struct Brew {
    let brewId: UUID
    let brewMethod: BrewMethod
    let grains: GrainMethod?
    let coffee: Int // in grams
    let water: Int // in ml
    let duration: Measurement<UnitDuration>? // in seconds
    let creationDate: Date
    let brewScore: CoffeeValuation?
    
    init(brewMethod: BrewMethod, grains: GrainMethod?, coffee: Int, water: Int, duration: Measurement<UnitDuration>?, brewScore: CoffeeValuation?, creationDate: Date) {
        self.id = UUID()
        self.brewMethod = brewMethod
        self.grains = grains
        self.coffee = coffee
        self.water = water
        self.duration = duration
        self.brewScore = brewScore
        self.creationDate = creationDate
    }
}
