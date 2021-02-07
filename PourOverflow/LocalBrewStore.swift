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

        var randomValuation: CoffeeValuation?
        if valuation {
            randomValuation = CoffeeValuation.allCases.randomElement()!
        }

        let previousDays = Int.random(in: 1...90)
        let randomCreationDate = Calendar.current.date(byAdding: .day, value: -previousDays, to: Date())!

        let shouldHaveImage = Bool.random()
        let availableImages = ["brew-2feb", "brew-3feb"]
        let selectedImage = shouldHaveImage ? availableImages[Int.random(in: 0...1)] : nil

        let randomAromaQuantity = Int.random(in: 1...5)
        let randomAromaQuality = Int.random(in: 1...5)
        let randomAcidityQuantity = Int.random(in: 1...5)
        let randomAcidityQuality = Int.random(in: 1...5)
        let randomSweetnessQuantity = Int.random(in: 1...5)
        let randomSweetnessQuality = Int.random(in: 1...5)
        let randomBodyQuantity = Int.random(in: 1...5)
        let randomBodyQuality = Int.random(in: 1...5)
        let randomAftertasteQuantity = Int.random(in: 1...5)
        let randomAftertasteQuality = Int.random(in: 1...5)

        let availableFlavourNotes = ["A dark roast, loved it but hard to find.", "Brew was too fast.", ""]
        let randomFlavourNotes = availableFlavourNotes[Int.random(in: 0...2)]

        let availableRandomNotes = ["Fruits", "Like chocolate", "Tastes like cheesecake"]
        let randomNotes = availableRandomNotes[Int.random(in: 0...2)]

        return Brew(brewMethod: randomMethod,
                    grains: randomGrains,
                    coffee: randomCoffee,
                    water: randomWater,
                    duration: randomDuration,
                    brewScore: randomValuation,
                    creationDate: randomCreationDate,
                    imageAddress: selectedImage,
                    aromaQuantity: randomAromaQuantity,
                    aromaQuality: randomAromaQuality,
                    acidityQuantity: randomAcidityQuantity,
                    acidityQuality: randomAcidityQuality,
                    sweetnessQuantity: randomSweetnessQuantity,
                    sweetnessQuality: randomSweetnessQuality,
                    bodyQuantity: randomBodyQuantity,
                    bodyQuality: randomBodyQuality,
                    aftertasteQuantity: randomAftertasteQuantity,
                    aftertasteQuality: randomAftertasteQuality,
                    flavourNotes: randomFlavourNotes,
                    notes: randomNotes)
    }

    func brewsInDateRange(fromDate from: Date, toDate: Date) -> [Brew] {
        let filteredBrews = allBrews.filter { $0.creationDate >= from && $0.creationDate <= toDate }
        return filteredBrews.sorted {
            $0.creationDate < $1.creationDate
        }
    }

    func brewsByMethod(brewMethods: [BrewMethod], fromDate: Date?, toDate: Date?) -> [Brew] {
        if let from = fromDate, let until = toDate {
            let brewsInRange = brewsInDateRange(fromDate: from, toDate: until)
            let byMethod = brewsInRange.filter { brewMethods.contains($0.brewMethod) }
            return byMethod
        } else {
            return allBrews.filter { brewMethods.contains($0.brewMethod) }
        }
    }

    func brewsInDate(date: Date) -> [Brew] {
        let start = Calendar.current.startOfDay(for: date)
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        let endOfDay = Calendar.current.date(byAdding: .second, value: -1, to: nextDay)!

        return brewsInDateRange(fromDate: start, toDate: endOfDay)
    }

    init() {
        for _ in 0..<80 {
            addRandomBrew(hasValuation: true)
        }
        for _ in 0..<10 {
            addRandomBrew()
        }
    }
}
