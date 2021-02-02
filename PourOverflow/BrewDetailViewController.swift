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

    override func viewWillLayoutSubviews() {
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        self.view.addSubview(navigationBar)

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")

        let navigationItem = UINavigationItem(title: "")
        let doneButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(donePressed))
        navigationItem.rightBarButtonItem = doneButton
        navigationBar.setItems([navigationItem], animated: false)

        var newSafeArea = UIEdgeInsets()
        newSafeArea.top += 60
        self.additionalSafeAreaInsets = newSafeArea
    }

    @objc func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
