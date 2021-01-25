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

        if let brewListViewController = viewControllers?.first as? BrewListNavigationController {
            brewListViewController.brewStore = brewStore
        }

        if let calendarViewController = viewControllers?[1] as? CalendarViewController {
            calendarViewController.brewStore = brewStore
        }
    }
}
