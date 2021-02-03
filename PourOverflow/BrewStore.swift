//
//  BrewStore.swift
//  PourOverflow
//
import Foundation

protocol BrewStore {
    var allBrews: [Brew] { get }
    func brewsInDateRange(fromDate: Date, toDate: Date) -> [Brew]
    func brewsInDate(date: Date) -> [Brew]
    func brewsByMethod(brewMethod: BrewMethod, fromDate: Date?, toDate: Date?) -> [Brew]
}
