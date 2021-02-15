//
//  NewBrewDetailsTableViewController.swift
//  PourOverflow
//
//  Created by marto on 12/02/21.
//

import UIKit

class NewBrewDetailsTableViewController: UITableViewController {
    override func viewDidLoad() {
        self.brewTimeTextField.delegate = self
    }
    @IBOutlet var brewTimeTextField: UITextField!
}

extension NewBrewDetailsTableViewController: UITextFieldDelegate {

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