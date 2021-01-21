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
    
    var selectedDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectedMonthString()
        fillCalendar()
    }
    
    func fillCalendar() {
        if let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate) {
            // get brewStores filtered by self.currentMonth
            let brews = brewStore.brewsInDateRange(from: previousMonth, to:selectedDate)
            for index in 0...41 {
                let button = dayButtons[index]
                button.setTitle("-", for: .normal)
            }
            if brews.count > 0 {
                // paint them in dayButtons *by tag [0-41]
                let weekday = Calendar.current.component(.weekday, from: selectedDate)
                // get first day of the month and match with weekday
                var brewIndex = weekday - 1 // index 1-7
                for brew in brews {
                    let button = dayButtons[brewIndex]
                    button.setTitle("\(brew.score)", for: .normal)
                    brewIndex += 1
                }
            }
        }
    }
    
    func setSelectedMonthString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        currentMonthLabel.text = dateFormatter.string(from: selectedDate)
    }
    
    @IBAction func decreaseMonth(_ sender: UIButton) {
        if let newSelectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate) {
            selectedDate = newSelectedDate
            setSelectedMonthString()
            fillCalendar()
        }
    }
    
    @IBAction func increaseMonth(_ sender: UIButton) {
        if let newSelectedDate = Calendar.current.date(byAdding: .month, value: +1, to: selectedDate) {
            selectedDate = newSelectedDate
            setSelectedMonthString()
            fillCalendar()
        }
    }
}
