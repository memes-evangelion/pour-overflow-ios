//
//  BrewListNavigationController.swift
//  PourOverflow
//
//  Created by marto on 17/01/21.
//

import UIKit

class BrewListNavigationController: UINavigationController {
    var brewStore: BrewStore!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let firstController = viewControllers.first  {
            let brewListViewController = firstController as! BrewListViewController
            brewListViewController.brewStore = brewStore
        }
        
    }
}
