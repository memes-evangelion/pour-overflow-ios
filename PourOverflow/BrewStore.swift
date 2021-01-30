//
//  BrewStore.swift
//  PourOverflow
//
import Foundation

protocol BrewStore {
    var allBrews: [Brew] { get }
    func brewsInDateRange(fromDate: Date, toDate: Date) -> [Brew]
    func brewsInDate(date: Date) -> [Brew]
    func allBrewsByMonth() -> ([String], [[Brew]])
}
