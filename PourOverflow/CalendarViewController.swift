//
//  CalendarViewController.swift
//  PourOverflow
//
//  Created by marto on 19/01/21.
//

import UIKit

class CalendarViewController: UIViewController {
    unowned var brewStore: BrewStore!
    let notificationCenter = NotificationCenter.default

    @IBOutlet var currentMonthLabel: UILabel!
    @IBOutlet var dayButtons: [UIButton]!

    var selectedDate: Date!
    var displayDate: Date!

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedDate = getFirstDayOfMonth(date: Date())
        displayDate = getFirstDayOfMonth(date: Date())

        displayMonthLabel()
        fillCalendar()

        notificationCenter.addObserver(self, selector: #selector(refreshCalendar), name: Notification.Name(Notifications.BrewCreated.rawValue), object: nil)
    }

    @objc func refreshCalendar() {
        fillCalendar()
    }

    deinit {
        notificationCenter.removeObserver(self)
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
        let daysRange = Calendar.current.range(of: .day, in: .month, for: selectedDate)!
        for dayNumber in daysRange {
            let firstButtonOfMonth = firstWeekdayOfMonth - 2
            let dayInButtons = firstButtonOfMonth + dayNumber
            let button = dayButtons[dayInButtons]
            button.setTitle("\(dayNumber)\n", for: .normal)
        }

        if brews.count > 0 {
            // Initial weekday of the month
            let brewIndex = firstWeekdayOfMonth - 2
            for brew in brews {
                let day = Calendar.current.component(.day, from: brew.creationDate)
                // Set position against initial weekday in array
                let button = dayButtons[brewIndex + day]
                let buttonTitle = button.currentTitle!
                let lines = buttonTitle.split(whereSeparator: \.isNewline)
                let score = CoffeeValuation(score: brew.score)?.rawValue ?? "☕️"


                if lines.count > 1 {
                    button.setTitle("\(day)\n\(score)+", for: .normal)
                } else {
                    button.setTitle("\(day)\n\(score)", for: .normal)
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

    @IBAction func displayDayBrews(_ sender: UIButton) {
        guard let buttonTitle = sender.currentTitle else {
            preconditionFailure("Unknown sender")
        }

        let lines = buttonTitle.split(whereSeparator: \.isNewline)

        guard lines.count >= 2 && !lines[1].trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }

        let daySelected = Int(lines[0])
        var dateComponents = Calendar.current.dateComponents([.year, .month], from: selectedDate)
        dateComponents.day = daySelected

        displayDate = Calendar.current.date(from: dateComponents)!

        let dayBrews = brewStore.brewsInDate(date: displayDate)
        if dayBrews.count > 1 {
            performSegue(withIdentifier: "showDayBrews", sender: dayBrews)
        } else {
            performSegue(withIdentifier: "showDayBrewDetail", sender: dayBrews)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showDayBrews":
            if let brewListNavViewController = segue.destination as? BrewListNavigationController {
                brewListNavViewController.brewStore = brewStore
                brewListNavViewController.selectedDay = displayDate
                brewListNavViewController.setDoneButton = true
            }
        case "showDayBrewDetail":
            let dayBrews = brewStore.brewsInDate(date: displayDate)
            if let brewDetailNavigationViewController = segue.destination as? BrewDetailNavigationController {
                brewDetailNavigationViewController.brew = dayBrews[0]
            }
        default:
            preconditionFailure("Unknown segue")
        }
    }
}
