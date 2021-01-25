//
//  CalendarViewController.swift
//  PourOverflow
//
//  Created by marto on 19/01/21.
//

import UIKit

class CalendarViewController: UIViewController {
    var brewStore: BrewStore!

    @IBOutlet var currentMonthLabel: UILabel!
    @IBOutlet var dayButtons: [UIButton]!

    var selectedDate: Date!

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedDate = getFirstDayOfMonth(date: Date())

        displayMonthLabel()
        fillCalendar()
    }

    func fillCalendar() {
        let lastDayOfMonth = getLastDayOfMonth(date: selectedDate)
        let brews = brewStore.brewsInDateRange(fromDate: selectedDate, toDate: lastDayOfMonth)
        for index in 0...41 {
            let button = dayButtons[index]
            button.setTitle("-", for: .normal)
            button.isEnabled = false
        }
        
        let firstWeekdayOfMonth = Calendar.current.component(.weekday, from: selectedDate)
        
        let daysRange = Calendar.current.range(of: .day, in: .month, for:selectedDate)!
        for dayNumber in daysRange {
            let firstButtonOfMonth = firstWeekdayOfMonth - 1
            let dayInButtons = firstButtonOfMonth + dayNumber
            let button = dayButtons[dayInButtons]
            button.setTitle("\(dayNumber)\n", for: .normal)
            button.isEnabled = true
        }

        if brews.count > 0 {
            // Initial weekday of the month
            let brewIndex = firstWeekdayOfMonth - 1
            for brew in brews {
                let day = Calendar.current.component(.day, from: brew.creationDate)
                // Set position against initial weekday in array
                let button = dayButtons[brewIndex + day]
                if let score = brew.brewScore?.rawValue {
                    button.setTitle("\(day)\n\(score)", for: .normal)
                } else {
                    button.setTitle("\(day)\n☕️", for: .normal)
                }
                button.isEnabled = true
            }
        }
    }

    func displayMonthLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL Y"
        currentMonthLabel.text = dateFormatter.string(from: selectedDate)
    }

    @IBAction func decreaseMonth(_ sender: UIButton) {
        guard let newSelectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate) else {
            preconditionFailure("Error substracting a month from date")
        }

        selectedDate = getFirstDayOfMonth(date: newSelectedDate)
        displayMonthLabel()
        fillCalendar()
    }

    @IBAction func increaseMonth(_ sender: UIButton) {
        guard let newSelectedDate = Calendar.current.date(byAdding: .month, value: +1, to: selectedDate) else {
            preconditionFailure("Error increasing a month from date")
        }

        guard newSelectedDate <= Date() else {
            return
        }

        selectedDate = getFirstDayOfMonth(date: newSelectedDate)
        displayMonthLabel()
        fillCalendar()
    }

    func getFirstDayOfMonth(date: Date) -> Date {
        let startComponents = Calendar.current.dateComponents([.year, .month], from: date)
        return Calendar.current.date(from: startComponents)!
    }

    func getLastDayOfMonth(date: Date) -> Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: date)!
    }
}
