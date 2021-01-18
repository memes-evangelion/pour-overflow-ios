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
        
        brewMethodTextField.text = "\(brew.brewMethod)"
        coffeeTextField.text = "\(brew.coffee) g"
        waterTextField.text = "\(brew.water) ml"
        timeTextField.text = "\(String(describing: brew.duration)) seconds"
        brewDateTextField.text = "\(brew.creationDate)"
        scoreLabel.text = "\(brew.score)"
    }
}
