//
//  BrewDetailNavigationController.swift
//  PourOverflow
//
//  Created by marto on 02/02/21.
//

import UIKit

class BrewDetailNavigationController: UINavigationController, UINavigationControllerDelegate {
    var brew: Brew!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        if let brewDetailViewController = viewControllers.first as? BrewDetailViewController {
            brewDetailViewController.brew = brew
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        viewController.navigationItem.rightBarButtonItem = doneButton
    }

    @objc func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
