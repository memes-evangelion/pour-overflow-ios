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
    
    var selectedDateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
    
    var currentMonth = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectedMonthString()
        //fillCalendar
    }
    
    func fillCalendar() {

        // get brewStores filtered by self.currentMonth
        // paint them in dayButtons *by tag [0-41]
        
    }
    
    func setSelectedMonthString() {
        currentMonth = selectedDateComponents.month! - 1

        let monthsArray = ["January","February","March","April","May","June","July","August","September","October","November","December"]
        currentMonthLabel.text = monthsArray[currentMonth]

    }
    
    @IBAction func decreaseMonth(_ sender: UIButton) {
        let newMonth = currentMonth - 1
        
        // remove one month from selectedDateComponents
        // recalculate year
        if newMonth >= 0 {
            currentMonth = newMonth
        } else {
            currentMonth = 11
        }
        setSelectedMonthString()
        // fillCalendar
    }
    
    @IBAction func increaseMonth(_ sender: UIButton) {
        // avoid future Months
        let newMonth = currentMonth + 1
        if newMonth < 12 {
            currentMonth = newMonth
        } else {
            currentMonth = 0
        }
        setSelectedMonthString()
        // fillCalendar
    }
}
