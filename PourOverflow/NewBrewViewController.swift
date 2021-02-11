//
//  NewBrewViewController.swift
//  PourOverflow
//
//  Created by marto on 06/01/21.
//

import UIKit

class NewBrewViewController: UIViewController {
    @IBOutlet var brewMethodPicker: UIPickerView!

    @IBAction func cancelCreation(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    var brewStore: BrewStore!

    override func viewDidLoad() {
        brewMethodPicker.dataSource = self
        brewMethodPicker.delegate = self
    }
}

extension NewBrewViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BrewMethod.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BrewMethod.allCases[row].rawValue
    }

}
