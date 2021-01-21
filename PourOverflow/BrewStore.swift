//
//  BrewStore.swift
//  PourOverflow
//
import Foundation

protocol BrewStore {
    var allBrews: [Brew] { get }
    func brewsInDateRange(from: Date, to: Date) -> [Brew]
}
