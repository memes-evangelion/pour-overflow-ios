//
//  BrewStore.swift
//  PourOverflow
//
//  Created by marto on 11/01/21.
//
import Foundation

class LocalBrewStore: BrewStore {
    
    var allBrews = [Brew]()
    
    @discardableResult func createRandomBrew(hasValuation: Bool = false) -> Brew {
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
        let randomDuration = Measurement(value:randomSeconds, unit: UnitDuration.seconds)
        
        var randomValuation: CoffeeValuation?
        if valuation {
            randomValuation = CoffeeValuation.allCases.randomElement()!
        }
        
        let previousDays = Int.random(in: 1...120)
        let randomCreationDate = Calendar.current.date(byAdding: .day, value: -previousDays, to: Date())!

        
        return Brew(brewMethod: randomMethod, grains: randomGrains, coffee: randomCoffee, water: randomWater, duration: randomDuration, valuation: randomValuation, creationDate: randomCreationDate)
    }
    
    func brewsInDateRange(from: Date, to: Date) -> [Brew] {
        let filteredBrews = allBrews.filter { $0.creationDate >= from && $0.creationDate <= to }
        return filteredBrews.sorted {
            $0.creationDate < $1.creationDate
        }
    }
    
    init() {
        for _ in 0..<30 {
            createRandomBrew(hasValuation: true)
        }
        for _ in 0..<10 {
            createRandomBrew()
        }
    }
}
