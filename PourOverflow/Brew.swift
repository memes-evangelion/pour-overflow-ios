//
//  Brew.swift
//  PourOverflow
//
//  Created by marto on 09/01/21.
//

import UIKit

enum BrewMethod: String, CaseIterable {
    case harioSwitch, aeroPress, v60, kalitaWave, chemex, espresso
    init?(value: String) {
        switch value.lowercased() {
        case BrewMethod.harioSwitch.rawValue.lowercased():
            self = BrewMethod.harioSwitch
        case BrewMethod.aeroPress.rawValue.lowercased():
            self = BrewMethod.aeroPress
        case BrewMethod.v60.rawValue.lowercased():
            self = BrewMethod.v60
        case BrewMethod.kalitaWave.rawValue.lowercased():
            self = BrewMethod.kalitaWave
        case BrewMethod.chemex.rawValue.lowercased():
            self = BrewMethod.chemex
        case BrewMethod.espresso.rawValue.lowercased():
            self = BrewMethod.espresso
        default:
            return nil
        }
    }

    static func matchingMethods(text: String) -> [BrewMethod] {
        let lowercasedText = text.lowercased()
        let methodsNames = BrewMethod.allCases.map { $0.rawValue.lowercased() }
        let matchingMethodNames = methodsNames.filter { $0.starts(with: lowercasedText) }
        return matchingMethodNames.compactMap { BrewMethod(value: $0) }
    }
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

    let aromaQuantity: Int?
    let aromaQuality: Int?
    let acidityQuantity: Int?
    let acidityQuality: Int?
    let sweetnessQuantity: Int?
    let sweetnessQuality: Int?
    let bodyQuantity: Int?
    let bodyQuality: Int?
    let aftertasteQuantity: Int?
    let aftertasteQuality: Int?

    let flavourNotes: String?
    let notes: String?

    init(brewMethod: BrewMethod, grains: GrainMethod?, coffee: Int, water: Int, duration: Measurement<UnitDuration>?,
         brewScore: CoffeeValuation?, creationDate: Date, imageAddress: String?, aromaQuantity: Int?, aromaQuality: Int?, acidityQuantity: Int?, acidityQuality: Int?, sweetnessQuantity: Int?, sweetnessQuality: Int?, bodyQuantity: Int?, bodyQuality: Int?, aftertasteQuantity: Int?, aftertasteQuality: Int?, flavourNotes: String?, notes: String?) {
        self.brewId = UUID()
        self.brewMethod = brewMethod
        self.grains = grains
        self.coffee = coffee
        self.water = water
        self.duration = duration
        self.brewScore = brewScore
        self.creationDate = creationDate
        self.imageAddress = imageAddress
        self.aromaQuantity = aromaQuantity
        self.aromaQuality = aromaQuality
        self.acidityQuantity = acidityQuantity
        self.acidityQuality = acidityQuality
        self.sweetnessQuantity = sweetnessQuantity
        self.sweetnessQuality = sweetnessQuality
        self.bodyQuantity = bodyQuantity
        self.bodyQuality = bodyQuality
        self.aftertasteQuantity = aftertasteQuantity
        self.aftertasteQuality = aftertasteQuality
        self.flavourNotes = flavourNotes
        self.notes = notes
    }
}
