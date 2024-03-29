//
//  BrewStore.swift
//  PourOverflow
//
//  Created by marto on 11/01/21.
//
import Foundation

class LocalBrewStore: BrewStore {

    var allBrews = [Brew]()

    @discardableResult func addRandomBrew(hasValuation: Bool = false) -> Brew {
        let randomBrew = LocalBrewStore.createRandomBrew(withValuation: hasValuation)
        allBrews.append(randomBrew)

        return randomBrew
    }

    static func createRandomBrew(withValuation valuation: Bool = false) -> Brew {
        let randomMethod = BrewMethod.allCases.randomElement()!
        let randomGrains = GrainMethod.allCases.randomElement()!

        let randomCoffee = Int.random(in: 10...30)
        let randomWater = Int.random(in: 100...300)

        let randomSeconds = Double.random(in: 20...400)
        let randomDuration = Measurement(value: randomSeconds, unit: UnitDuration.seconds)


        let previousDays = Int.random(in: 1...90)
        let randomCreationDate = Calendar.current.date(byAdding: .day, value: -previousDays, to: Date())!

        let randomNumberUpToFive = {
            return Int.random(in: 1...5)
        }

        let aroma = TastingProperty(quantity: randomNumberUpToFive(), quality: randomNumberUpToFive())
        let acidity = TastingProperty(quantity: randomNumberUpToFive(), quality: randomNumberUpToFive())
        let sweetness = TastingProperty(quantity: randomNumberUpToFive(), quality: randomNumberUpToFive())
        let body = TastingProperty(quantity: randomNumberUpToFive(), quality: randomNumberUpToFive())
        let finish = TastingProperty(quantity: randomNumberUpToFive(), quality: randomNumberUpToFive())

        let availableFlavourNotes = ["A dark roast, loved it but hard to find.", "Brew was too fast.", ""]
        let randomFlavourNotes = availableFlavourNotes[Int.random(in: 0...2)]

        let availableRandomNotes = ["Fruits", "Like chocolate", "Tastes like cheesecake"]
        let randomNotes = availableRandomNotes[Int.random(in: 0...2)]

        let randomGrind = ["Medium Fine", "Fine", "Coarse"]

        return Brew(brewMethod: randomMethod,
                    grains: randomGrains,
                    coffee: randomCoffee,
                    water: randomWater,
                    duration: randomDuration,
                    score: Int.random(in: -1...10),
                    creationDate: randomCreationDate,
                    aroma: aroma,
                    acidity: acidity,
                    sweetness: sweetness,
                    body: body,
                    finish: finish,
                    flavourNotes: randomFlavourNotes,
                    notes: randomNotes,
                    grind: randomGrind.randomElement(),
                    image: nil)
    }

    func brewsInDateRange(fromDate from: Date, toDate: Date) -> [Brew] {
        let filteredBrews = allBrews.filter { $0.creationDate >= from && $0.creationDate <= toDate }
        return filteredBrews.sorted {
            $0.creationDate < $1.creationDate
        }
    }
    
    func saveBrew(brew: Brew) {
        allBrews.append(brew)
    }

    init() {
        for _ in 0..<10 {
            addRandomBrew(hasValuation: true)
        }
        for _ in 0..<10 {
            addRandomBrew()
        }
    }
}
