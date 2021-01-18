//
//  BrewTabBarController.swift
//  PourOverflow
//
//  Created by marto on 17/01/21.
//

import UIKit

class BrewTabBarController: UITabBarController {
    var brewStore: BrewStore!
    // send to segues or views or such
    override func viewDidLoad() {
        super.viewDidLoad()
        // send store as well?
        if let firstController = viewControllers?.first  {
            let brewListViewController = firstController as! BrewListViewController
            brewListViewController.brewStore = brewStore
        }
        
    }
}
