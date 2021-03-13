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

    @IBOutlet var aromaView: TastingPropertyView!
    @IBOutlet var acidityView: TastingPropertyView!
    @IBOutlet var sweetnessView: TastingPropertyView!
    @IBOutlet var bodyView: TastingPropertyView!
    @IBOutlet var finishView: TastingPropertyView!

    @IBOutlet var brewImageButton: UIButton!

    var brew: Brew!

    @IBAction func showImageDetail(_ sender: UIButton) {
        performSegue(withIdentifier: "showFullImage", sender: sender)
    }

    private func setUpTastingPropertyView(tastingView: TastingPropertyView, tastingProperty: TastingProperty?) {
        tastingView.firstSlider.value = Float(tastingProperty?.quantity ?? 1)
        tastingView.secondSlider.value = Float(tastingProperty?.quality ?? 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")

        navigationItem.title = "\(brew.brewMethod.rawValue)"
        coffeeLabel.text = "\(brew.coffee)"
        waterLabel.text = "\(brew.water)"
        if let duration = brew.duration {
            let truncatedValue = String(format: "%.2f", duration.value)

            timeLabel.text = "\(truncatedValue) s"
        }
        brewDateLabel.text = "Brewed: \(dateFormatter.string(from: brew.creationDate))"
        if let brewScore = brew.score {
            scoreLabel.text = brewScore >= 0 ? "\(brewScore)/10" : "-"
        }
        
        if let imageData = brew.image {
            brewImage.image = UIImage(data: imageData)
            brewImageButton.isEnabled = true
        } else {
            brewImageButton.isEnabled = false
        }

        setUpTastingPropertyView(tastingView: aromaView, tastingProperty: brew.aroma)
        setUpTastingPropertyView(tastingView: acidityView, tastingProperty: brew.acidity)
        setUpTastingPropertyView(tastingView: sweetnessView, tastingProperty: brew.sweetness)
        setUpTastingPropertyView(tastingView: bodyView, tastingProperty: brew.body)
        setUpTastingPropertyView(tastingView: finishView, tastingProperty: brew.finish)

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
