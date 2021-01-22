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
    
    var lastOfMonth = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectedMonthString()
        fillCalendar()
    }
    
    func fillCalendar() {
        let firstDay = getFirstDayOfMonth(date: lastOfMonth)
        let brews = brewStore.brewsInDateRange(from: firstDay, to:lastOfMonth)
        for index in 0...41 {
            let button = dayButtons[index]
            button.setTitle("-", for: .normal)
        }
        if brews.count > 0 {
            let weekday = Calendar.current.component(.weekday, from: lastOfMonth)
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
    
    func setSelectedMonthString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        currentMonthLabel.text = dateFormatter.string(from: lastOfMonth)
    }
    
    @IBAction func decreaseMonth(_ sender: UIButton) {
        if let newSelectedDate = Calendar.current.date(byAdding: .month, value: -1, to: lastOfMonth) {

            let startOfMonth = getFirstDayOfMonth(date: newSelectedDate)
            let lastDayOfMonth = getLastDayOfMonth(date: startOfMonth)

            lastOfMonth = lastDayOfMonth
            setSelectedMonthString()
            fillCalendar()
        }
    }
    
    @IBAction func increaseMonth(_ sender: UIButton) {
        if let newSelectedDate = Calendar.current.date(byAdding: .month, value: +1, to: lastOfMonth) {
            if newSelectedDate < Date() {
                let startOfMonth = getFirstDayOfMonth(date: newSelectedDate)
                let lastDayOfMonth = getLastDayOfMonth(date: startOfMonth)

                lastOfMonth = lastDayOfMonth
            } else {
                lastOfMonth = Date()
            }
            
            setSelectedMonthString()
            fillCalendar()
        }
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
