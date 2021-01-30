//
//  BrewListNavigationController.swift
//  PourOverflow
//
//  Created by marto on 17/01/21.
//

import UIKit

class BrewListNavigationController: UINavigationController, UINavigationControllerDelegate {
    var brewStore: BrewStore!
    var selectedDay: Date?
    var setDoneButton = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        if let brewListViewController = viewControllers.first as? BrewListViewController {
            brewListViewController.brewStore = brewStore
            brewListViewController.selectedDay = selectedDay
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if setDoneButton {
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissController))
            viewController.navigationItem.rightBarButtonItem = doneButton
        }
    }

    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
}
