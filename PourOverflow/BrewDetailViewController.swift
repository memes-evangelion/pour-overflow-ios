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

    @IBOutlet var aromaQuantitySlider: UISlider!
    @IBOutlet var aromaQualitySlider: UISlider!

    @IBOutlet var acidityQuantitySlider: UISlider!
    @IBOutlet var acidityQualitySlider: UISlider!

    @IBOutlet var sweetnessQuantitySlider: UISlider!
    @IBOutlet var sweetnessQualitySlider: UISlider!

    @IBOutlet var bodyQuantitySlider: UISlider!
    @IBOutlet var bodyQualitySlider: UISlider!

    @IBOutlet var aftertasteQuantitySlider: UISlider!
    @IBOutlet var aftertasteQualitySlider: UISlider!

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

        if let aromaQuantity = brew.aromaQuantity, let aromaQuality = brew.aromaQuantity {
            aromaQuantitySlider.value = Float(aromaQuantity)
            aromaQualitySlider.value = Float(aromaQuality)
        }

        if let acidityQuantity = brew.acidityQuantity, let acidityQuality = brew.acidityQuality {
            acidityQualitySlider.value = Float(acidityQuality)
            acidityQuantitySlider.value = Float(acidityQuantity)
        }

        if let sweetnessQuantity = brew.sweetnessQuantity, let sweetnessQuality = brew.sweetnessQuality {
            sweetnessQuantitySlider.value = Float(sweetnessQuantity)
            sweetnessQualitySlider.value = Float(sweetnessQuality)
        }

        if let bodyQuantity = brew.bodyQuantity, let bodyQuality = brew.bodyQuality {
            bodyQuantitySlider.value = Float(bodyQuantity)
            bodyQualitySlider.value = Float(bodyQuality)
        }

        if let aftertasteQuantity = brew.aftertasteQuantity, let aftertasteQuality = brew.aftertasteQuality {
            aftertasteQuantitySlider.value = Float(aftertasteQuantity)
            aftertasteQualitySlider.value = Float(aftertasteQuality)
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
