//
//  BrewDetails.swift
//  PourOverflow
//
//  Created by Martin Granados Garcia on 2/18/21.
//

import Foundation

protocol BrewDetails {
    var water: Int { get }
    var coffee: Int { get }
    var grind: String { get }
    var time: Measurement<UnitDuration> { get }
    var tasteRatings: [(name: String, tasting: TastingProperty)] { get }
    var notes: String { get }
    var rating: Int { get }
}
