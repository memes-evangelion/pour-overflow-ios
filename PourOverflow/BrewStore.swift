//
//  BrewStore.swift
//  PourOverflow
//
//  Created by marto on 11/01/21.
//

import UIKit

class BrewStore {
    
    var allBrews = [Brew]()
    
    @discardableResult func createRandomBrew() -> Brew {
        let randomBrew = Brew.createRandomBrew()
        allBrews.append(randomBrew)
        
        return randomBrew
    }
    
    // init create unos brew random
    init() {
        for _ in 0..<5 {
            createRandomBrew()
        }
    }
}
