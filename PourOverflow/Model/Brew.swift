//
//  Brew.swift
//  PourOverflow
//
//  Created by marto on 09/01/21.
//

import UIKit

enum BrewMethod: String, CaseIterable {
    case harioSwitch, aeroPress, v60, kalitaWave, chemex, espresso, frenchPress, mokaPot
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
        case BrewMethod.frenchPress.rawValue.lowercased():
            self = BrewMethod.frenchPress
        case BrewMethod.mokaPot.rawValue.lowercased():
            self = BrewMethod.mokaPot
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

enum GrainMethod: String, CaseIterable {
    case lavado, honey, natural
}

enum CoffeeValuation: String, CaseIterable {
    case horrible = "🤮"
    case bad = "☹️"
    case neutral = "😐"
    case good = "🙂"
    case amazing = "🤩"

    init?(score: Int?) {
        guard let brewScore = score else {
            return nil
        }
        switch brewScore {
        case 0...2:
            self = .horrible
        case 3...4:
            self = .bad
        case 5...6:
            self = .neutral
        case 7...8:
            self = .good
        case 9...10:
            self = .amazing
        default:
            return nil
        }
    }
}

struct TastingProperty {
    let quantity: Int
    let quality: Int
}

struct Brew {
    let brewId: UUID
    let brewMethod: BrewMethod
    let grains: GrainMethod?
    let coffee: Int // in grams
    let water: Int // in ml
    let duration: Measurement<UnitDuration>? // in seconds
    let creationDate: Date
    let score: Int?
    let imageAddress: String?
    let grind: String?

    let aroma: TastingProperty?
    let acidity: TastingProperty?
    let sweetness: TastingProperty?
    let body: TastingProperty?
    let finish: TastingProperty?

    let flavourNotes: String?
    let notes: String?

    init(brewMethod: BrewMethod, grains: GrainMethod?, coffee: Int, water: Int,
         duration: Measurement<UnitDuration>?,
         score: Int?, creationDate: Date, imageAddress: String?,
         aroma: TastingProperty?, acidity: TastingProperty?, sweetness: TastingProperty?,
         body: TastingProperty?, finish: TastingProperty?, flavourNotes: String?,
         notes: String?, grind: String?) {
        self.brewId = UUID()
        self.brewMethod = brewMethod
        self.grains = grains
        self.coffee = coffee
        self.water = water
        self.duration = duration
        self.score = score
        self.creationDate = creationDate
        self.imageAddress = imageAddress
        self.aroma = aroma
        self.acidity = acidity
        self.sweetness = sweetness
        self.body = body
        self.finish = finish
        self.flavourNotes = flavourNotes
        self.notes = notes
        self.grind = grind
    }

    init(from model: BrewModel) {
        let brewMethod = BrewMethod(rawValue: model.brewMethodRawValue)!
        let grains = GrainMethod(rawValue: model.grainsRawValue ?? "")
        let duration = Measurement(value: Double(model.duration), unit: UnitDuration.seconds)
        let aromaTastingProperty = TastingProperty(quantity: model.aromaQuantity, quality: model.aromaQuality)
        let acidityTastingProperty = TastingProperty(quantity: model.acidityQuantity, quality: model.acidityQuality)
        let sweetnessTastingProperty = TastingProperty(quantity: model.sweetnessQuantity, quality: model.sweetnessQuality)
        let bodyTastingProperty = TastingProperty(quantity: model.bodyQuantity, quality: model.bodyQuality)
        let finishTastingProperty = TastingProperty(quantity: model.finishQuantity, quality: model.finishQuality)

        self.init(brewMethod: brewMethod, grains: grains, coffee: model.coffee, water: model.water, duration: duration, score: model.score, creationDate: model.creationDate, imageAddress: model.imageAddress, aroma: aromaTastingProperty, acidity: acidityTastingProperty, sweetness: sweetnessTastingProperty, body: bodyTastingProperty, finish: finishTastingProperty, flavourNotes: model.flavourNotes, notes: model.notes, grind: model.grind)
    }
}
