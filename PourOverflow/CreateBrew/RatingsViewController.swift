//
//  RatingsViewController.swift
//  PourOverflow
//
//  Created by marto on 12/02/21.
//

import UIKit

class RatingsViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tastingRatingViews: [TastingPropertyView]!

    @IBOutlet var flavourNotes: UITextField!
    @IBOutlet var ratingTextField: UITextField!

    var delegate: RatingsViewDelegate?

    @IBAction func saveRatings(_ sender: UIBarButtonItem) {
        var tastingRatings : [(name: String, tasting: TastingProperty)] = []
        for tastingView in tastingRatingViews {
            let tastingPropertyValues = TastingProperty(quantity: Int(tastingView.firstSlider.value), quality: Int(tastingView.secondSlider.value))
            tastingRatings.append((name: tastingView.propertyTitle.text!, tasting: tastingPropertyValues))
        }
        let notes = flavourNotes.text!
        let rating = Int(ratingTextField.text!) ?? -1

        dismiss(animated: true) {
            self.delegate?.saveRatings(tasteRatings: tastingRatings, notes: notes, rating: rating)
        }
    }

    @IBAction func dismissController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func showRatingInfo(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.youtube.com/watch?v=kEZZCQTSSAg")!, options: [:], completionHandler: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDissappear), name: UIResponder.keyboardWillHideNotification, object: nil)

        let gestures = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        scrollView.addGestureRecognizer(gestures)
    }

    @objc func keyboardWillAppear(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.cgRectValue.height
        }

    }

    @objc func keyboardWillDissappear(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
