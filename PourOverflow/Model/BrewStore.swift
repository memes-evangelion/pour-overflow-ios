//
//  BrewStore.swift
//  PourOverflow
//
import Foundation

protocol BrewStore: AnyObject {
    var allBrews: [Brew] { get }
    func brewsInDateRange(fromDate: Date, toDate: Date) -> [Brew]
    func brewsInDate(date: Date) -> [Brew]
    func brewsByMethod(brewMethods: [BrewMethod], fromDate: Date?, toDate: Date?) -> [Brew]
    func saveBrew(brew: Brew)
}

extension BrewStore {
    func brewsInDate(date: Date) -> [Brew] {
        let start = Calendar.current.startOfDay(for: date)
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        let endOfDay = Calendar.current.date(byAdding: .second, value: -1, to: nextDay)!
        return brewsInDateRange(fromDate: start, toDate: endOfDay)
    }
    func brewsByMethod(brewMethods: [BrewMethod], fromDate: Date?, toDate: Date?) -> [Brew] {
        if let from = fromDate, let until = toDate {
            let brewsInRange = brewsInDateRange(fromDate: from, toDate: until)
            let byMethod = brewsInRange.filter { brewMethods.contains($0.brewMethod) }
            return byMethod
        } else {
            return allBrews.filter { brewMethods.contains($0.brewMethod) }
        }
    }
}
