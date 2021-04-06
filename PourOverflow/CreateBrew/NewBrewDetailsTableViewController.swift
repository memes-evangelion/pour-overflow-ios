//
//  NewBrewDetailsTableViewController.swift
//  PourOverflow
//
//  Created by marto on 12/02/21.
//

import UIKit

class NewBrewDetailsTableViewController: UITableViewController, BrewDetails {
    var tasteRatings: [(name: String, tasting: TastingProperty)] = []

    var notes: String = ""

    var rating: Int = -1

    var water: Int {
        get {
            return Int(waterTextField.text ?? "0") ?? 0
        }
    }
    var coffee: Int {
        get {
            return Int(coffeeTextField.text ?? "0") ?? 0
        }
    }
    var grind: String {
        get {
            return grindTextField.text ?? ""
        }
    }
    var time: Measurement<UnitDuration>? {
        get {
            var seconds = 0
            let timeText = brewTimeTextField.text ?? ""
            guard let twoPoints = timeText.firstIndex(of: ":") else {
                return nil
            }

            let minutesFromString = timeText[..<twoPoints]
            let secondsFromString = timeText[timeText.index(twoPoints, offsetBy: 1)..<timeText.endIndex]

            seconds += (Int(String(minutesFromString)) ?? 0 ) * 60
            seconds += Int(String(secondsFromString)) ?? 0
            return Measurement(value: Double(seconds), unit: UnitDuration.seconds)
        }
    }

    @IBOutlet var tastingNotesStatus: UILabel!
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var coffeeTextField: UITextField!
    @IBOutlet var grindTextField: UITextField!
    @IBOutlet var brewTimeTextField: UITextField!

    override func viewDidLoad() {
        self.brewTimeTextField.delegate = self
        self.grindTextField.delegate = self
        addBarButtonItem(toTextField: waterTextField, withTitle: "Next")
        addBarButtonItem(toTextField: coffeeTextField, withTitle: "Next")
        addBarButtonItem(toTextField: brewTimeTextField, withTitle: "Done")
    }

    func addBarButtonItem(toTextField textField: UITextField, withTitle title: String) {
        let bar = UIToolbar()
        let next = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(moveToNextResponder))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [spacer, next]
        bar.sizeToFit()
        textField.inputAccessoryView = bar
    }

    @objc func moveToNextResponder() {
        if waterTextField.isFirstResponder {
            coffeeTextField.becomeFirstResponder()
        } else if coffeeTextField.isFirstResponder {
            grindTextField.becomeFirstResponder()
        } else if grindTextField.isFirstResponder {
            brewTimeTextField.becomeFirstResponder()
        } else if brewTimeTextField.isFirstResponder {
            brewTimeTextField.resignFirstResponder()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showRatings":
            if let ratingsNavigationViewController = segue.destination as? RatingsNavigationViewController {
                ratingsNavigationViewController.ratingsViewDelegate = self
            }
        default:
            preconditionFailure("Unknown segue")
        }
    }
}

extension NewBrewDetailsTableViewController: RatingsViewDelegate {
    func saveRatings(tasteRatings: [(name: String, tasting: TastingProperty)], notes: String, rating: Int) {
        self.tasteRatings = tasteRatings
        self.notes = notes
        self.rating = rating
        self.tastingNotesStatus.text = "Rated"
    }
}

extension NewBrewDetailsTableViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == grindTextField {
            moveToNextResponder()
        }
        return false
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            // Delete button was called
            textField.text = "0:00"
            return true
        }
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard textField.text != nil else {
            return
        }

        let timeText = textField.text!
        switch timeText.count {
        case 1:
            textField.text = "0:0\(timeText)"
        case 3:
            textField.text = "0:00"
        case 4:
            var formatted = timeText
            formatted.remove(at: formatted.firstIndex(of: ":")!)
            // e.g. 34:4
            let newColonIndex = formatted.index(formatted.endIndex, offsetBy: -2)
            formatted.insert(":", at: newColonIndex)
            textField.text = formatted
        case 5:
            if timeText.starts(with: "0:0") {
                let previousToLast = timeText.index(timeText.endIndex, offsetBy: -2)
                textField.text = "0:\(timeText[previousToLast..<timeText.endIndex])"
            } else if timeText.starts(with: "0:") {
                let minuteIndex = timeText.index(timeText.endIndex, offsetBy: -3)
                let secondsIndex = timeText.index(timeText.endIndex, offsetBy: -2)
                textField.text = "\(timeText[minuteIndex]):\(timeText[secondsIndex..<timeText.endIndex])"
            } else {
                var formatted = timeText
                formatted.remove(at: formatted.firstIndex(of: ":")!)
                // e.g. 3:444
                let colonIndex = formatted.index(formatted.startIndex, offsetBy: 2)
                formatted.insert(":", at: colonIndex)
                textField.text = formatted
            }

        case 6:
            var formatted = timeText
            formatted.remove(at: formatted.firstIndex(of: ":")!)

            let secondMinuteIndex = timeText.index(timeText.startIndex, offsetBy: 1)
            formatted = "\(formatted[secondMinuteIndex..<formatted.endIndex])"
            let colonIndex = formatted.index(formatted.startIndex, offsetBy: 2)
            formatted.insert(":", at: colonIndex)
            textField.text = formatted
        default:
            return
        }
    }
}
