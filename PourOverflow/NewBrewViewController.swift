//
//  NewBrewViewController.swift
//  PourOverflow
//
//  Created by marto on 06/01/21.
//

import UIKit

class NewBrewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func cancelCreation(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    var brewStore: BrewStore!
}
