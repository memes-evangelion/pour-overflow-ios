//
//  RatingsNavigationViewController.swift
//  PourOverflow
//
//  Created by Martin Granados Garcia on 2/23/21.
//

import UIKit

class RatingsNavigationViewController: UINavigationController {
    var ratingsViewDelegate: RatingsViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let ratingsViewController = viewControllers.first as? RatingsViewController {
            ratingsViewController.delegate = ratingsViewDelegate
        }
    }

    
}
