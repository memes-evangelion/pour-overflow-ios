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
    
    func brewsInDateRange(from: Date, to: Date) -> [Brew] {
        return allBrews.filter { $0.creationDate >= from && $0.creationDate <= to }
    }
    
    // Crear unos brew random
    init() {
        for _ in 0..<40 {
            createRandomBrew()
        }
    }
}
