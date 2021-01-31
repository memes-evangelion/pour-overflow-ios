//
//  BrewUtilities.swift
//  PourOverflow
//
//  Created by marto on 31/01/21.
//

import Foundation

class BrewUtilities {
    static func sectionsByMonth(brews: [Brew]) -> ([String], [[Brew]]) {
        var months: [String] = []
        var monthBrews: [[Brew]] = []

        let sortedAndFiltered = brews.sorted {
            $0.creationDate > $1.creationDate // Descending so recent brews are shown at the top
        }

        for brew in sortedAndFiltered {
            let dateComponents = Calendar.current.dateComponents([.year, .month], from: brew.creationDate)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL Y"
            let dateWithMonthOnly = Calendar.current.date(from: dateComponents)!
            let monthYearString = dateFormatter.string(from: dateWithMonthOnly)
            // Do the array dance
            if months.contains(monthYearString) {
                let existingMonthIndex = months.firstIndex(of: monthYearString)!
                monthBrews[existingMonthIndex].append(brew)
            } else {
                months.append(monthYearString)
                monthBrews.append([brew])
            }
        }
        return (months, monthBrews)
    }

    static func sectionsByDay(brews: [Brew]) -> ([String], [[Brew]]) {
        var days: [String] = []
        var monthBrews: [[Brew]] = []

        let sortedAndFiltered = brews.sorted {
            $0.creationDate > $1.creationDate // Descending so recent brews are shown at the top
        }

        for brew in sortedAndFiltered {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, YYYY"

            let dayString = dateFormatter.string(from: brew.creationDate)
            // Do the array dance
            if days.contains(dayString) {
                let existingMonthIndex = days.firstIndex(of: dayString)!
                monthBrews[existingMonthIndex].append(brew)
            } else {
                days.append(dayString)
                monthBrews.append([brew])
            }
        }

        return (days, monthBrews)
    }
}
