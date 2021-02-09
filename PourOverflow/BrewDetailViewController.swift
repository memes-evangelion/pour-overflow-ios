//
//  BrewDetailViewController.swift
//  PourOverflow
//
//  Created by marto on 17/01/21.
//

import UIKit

class BrewDetailViewController: UIViewController {
    @IBOutlet var waterLabel: UILabel!
    @IBOutlet var coffeeLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var grindLabel: UILabel!

    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var brewImage: UIImageView!
    @IBOutlet var brewDateLabel: UILabel!

    @IBOutlet var squareViews: [UIView]!

    @IBOutlet var notesTextField: UITextField!

    var brew: Brew!

    @IBAction func showImageDetail(_ sender: UIButton) {
        performSegue(withIdentifier: "showFullImage", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")

        navigationItem.title = "\(brew.brewMethod)"
        coffeeLabel.text = "\(brew.coffee)"
        waterLabel.text = "\(brew.water)"
        if let duration = brew.duration {
            let truncatedValue = String(format: "%.2f", duration.value)

            timeLabel.text = "\(truncatedValue) s"
        }
        brewDateLabel.text = "Brewed: \(dateFormatter.string(from: brew.creationDate))"
        scoreLabel.text = brew.brewScore?.rawValue
        if let imageFromBrew = brew.imageAddress {
            brewImage.image = UIImage(named: imageFromBrew)
        }

        if let notes = brew.notes {
            notesTextField.text = notes
        }

        for roundView in squareViews {
            roundView.layer.cornerRadius = 5
        }
        brewImage.layer.cornerRadius = 5
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showFullImage":
            if let brewImageViewController = segue.destination as? BrewImageViewController {
                    brewImageViewController.brewImage = brewImage.image
            }
        default:
            preconditionFailure("Unknown segue")
        }
    }
}
