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
    case horrible = "🤮"
    case bad = "☹️"
    case neutral = "😐"
    case good = "🙂"
    case amazing = "🤩"
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
    let imageAddress: String?

    init(brewMethod: BrewMethod, grains: GrainMethod?, coffee: Int, water: Int, duration: Measurement<UnitDuration>?, brewScore: CoffeeValuation?, creationDate: Date, imageAddress: String?) {
        self.brewId = UUID()
        self.brewMethod = brewMethod
        self.grains = grains
        self.coffee = coffee
        self.water = water
        self.duration = duration
        self.brewScore = brewScore
        self.creationDate = creationDate
        self.imageAddress = imageAddress
    }
}
