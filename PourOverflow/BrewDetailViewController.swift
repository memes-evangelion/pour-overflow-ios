//
//  BrewDetailViewController.swift
//  PourOverflow
//
//  Created by marto on 17/01/21.
//

import UIKit

class BrewDetailViewController: UIViewController {

    @IBOutlet var brewMethodTextField: UITextField!
    @IBOutlet var coffeeTextField: UITextField!
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var brewDateTextField: UITextField!
    @IBOutlet var scoreLabel: UILabel!

    var brew: Brew!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")

        brewMethodTextField.text = "\(brew.brewMethod)"
        coffeeTextField.text = "\(brew.coffee) g"
        waterTextField.text = "\(brew.water) ml"
        if let duration = brew.duration {
            let truncatedValue = String(format: "%.2f", duration.value)

            timeTextField.text = "\(truncatedValue) seconds"
        }
        brewDateTextField.text = "\(dateFormatter.string(from: brew.creationDate))"
        scoreLabel.text = brew.brewScore?.rawValue
    }
}
