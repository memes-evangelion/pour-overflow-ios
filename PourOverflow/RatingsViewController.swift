//
//  RatingsViewController.swift
//  PourOverflow
//
//  Created by marto on 12/02/21.
//

import UIKit

class RatingsViewController: UIViewController {
    @IBAction func dismissController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func showRatingInfo(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.youtube.com/watch?v=kEZZCQTSSAg")!, options: [:], completionHandler: nil)
    }
}
