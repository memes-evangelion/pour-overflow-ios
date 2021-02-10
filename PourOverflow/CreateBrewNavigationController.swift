//
//  CreateBrewNavigationController.swift
//  PourOverflow
//
//  Created by marto on 10/02/21.
//

import UIKit

class CreateBrewNavigationController: UINavigationController {
    var brewStore: BrewStore!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let createBrewViewController = viewControllers.first as? NewBrewViewController {
            createBrewViewController.brewStore = brewStore
        }
    }
}
