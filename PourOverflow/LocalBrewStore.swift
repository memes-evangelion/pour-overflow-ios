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

        return Brew(brewMethod: randomMethod, grains: randomGrains, coffee: randomCoffee, water: randomWater,
                    duration: randomDuration, brewScore: randomValuation, creationDate: randomCreationDate)
    }

    func brewsInDateRange(fromDate from: Date, toDate: Date) -> [Brew] {
        let filteredBrews = allBrews.filter { $0.creationDate >= from && $0.creationDate <= toDate }
        return filteredBrews.sorted {
            $0.creationDate < $1.creationDate
        }
    }

    func allBrewsByMonth() -> ([String], [[Brew]]) {
        var months: [String] = []
        var monthBrews: [[Brew]] = []

        let sortedAndFiltered = allBrews.sorted {
            $0.creationDate > $1.creationDate // Descending so recent brews are shown at the top
        }

        for brew in sortedAndFiltered {
            let dateComponents = Calendar.current.dateComponents([.year, .month], from: brew.creationDate)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL Y"
            let dateWithMonthOnly = Calendar.current.date(from: dateComponents)!
            let monthYearString = dateFormatter.string(from: dateWithMonthOnly)
            // Do the array dance
            if months.contains(monthYearString) {
                let existingMonthIndex = months.firstIndex(of: monthYearString)!
                monthBrews[existingMonthIndex].append(brew)
            } else {
                months.append(monthYearString)
                monthBrews.append([brew])
            }
        }
        return (months, monthBrews)
    }

    func brewsInDateByMethod(date: Date) -> ([String], [[Brew]]) {
        var methods: [String] = []
        var monthBrews: [[Brew]] = []

        let start = Calendar.current.startOfDay(for: date)
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        let endOfDay = Calendar.current.date(byAdding: .second, value: -1, to: nextDay)!

        let brews = brewsInDateRange(fromDate: start, toDate: endOfDay)

        let sortedAndFiltered = brews.sorted {
            $0.creationDate > $1.creationDate // Descending so recent brews are shown at the top
        }
        
        for brew in sortedAndFiltered {
            let brewType = "\(brew.brewMethod)"
            // Do the array dance
            if methods.contains(brewType) {
                let existingMonthIndex = methods.firstIndex(of: brewType)!
                monthBrews[existingMonthIndex].append(brew)
            } else {
                methods.append(brewType)
                monthBrews.append([brew])
            }
        }
        return (methods, monthBrews)
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
