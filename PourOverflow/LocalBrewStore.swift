//
//  BrewStore.swift
//  PourOverflow
//
//  Created by marto on 11/01/21.
//
import Foundation

class LocalBrewStore: BrewStore {

    var allBrews = [Brew]()

    @discardableResult func createRandomBrew() -> Brew {
        let randomBrew = Brew.createRandomBrew()
        allBrews.append(randomBrew)

        return randomBrew
    }

    func brewsInDateRange(fromDate: Date, toDate: Date) -> [Brew] {
        let filteredBrews = allBrews.filter { $0.creationDate >= fromDate && $0.creationDate <= toDate }
        return filteredBrews.sorted {
            $0.creationDate < $1.creationDate
        }
    }

    init() {
        for _ in 0..<30 {
            createRandomBrew()
        }
    }
}
