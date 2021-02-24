//
//  RatingsViewDelegate.swift
//  PourOverflow
//
//  Created by Martin Granados Garcia on 2/23/21.
//

protocol RatingsViewDelegate {
    func saveRatings(tasteRatings: [(name: String, tasting: TastingProperty)], notes: String, rating: Int) -> Void
}
