//
//  BrewTabBarController.swift
//  PourOverflow
//
//  Created by marto on 17/01/21.
//

import UIKit

class BrewTabBarController: UITabBarController {
    var brewStore: BrewStore!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let firstController = viewControllers?.first {
            let brewListViewController = firstController as! BrewListNavigationController
            brewListViewController.brewStore = brewStore
        }

        if let calendarController = viewControllers?[1] {
            let calendarViewController = calendarController as! CalendarViewController
            calendarViewController.brewStore = brewStore
        }

    }
}
