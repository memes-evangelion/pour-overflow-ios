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
        let brews = brewStore.brewsInDateRange(from: selectedDate, to:lastDayOfMonth)
        for index in 0...41 {
            let button = dayButtons[index]
            button.setTitle("-", for: .normal)
        }
        if brews.count > 0 {
            let weekday = Calendar.current.component(.weekday, from: selectedDate)
            // Initial weeday of the month
            let brewIndex = weekday - 1
            for brew in brews {
                let day = Calendar.current.component(.day, from: brew.creationDate)
                // Set position against initial weekday in array
                let button = dayButtons[brewIndex + day]
                button.setTitle("\(brew.score)", for: .normal)
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
