//
//  NewBrewViewController.swift
//  PourOverflow
//
//  Created by marto on 06/01/21.
//

import UIKit

class NewBrewViewController: UIViewController {
    @IBOutlet var brewMethodPicker: UIPickerView!
    @IBOutlet var coffeeIcon: UIImageView!
    @IBOutlet var brewPhotoImageView: UIImageView!

    var brewStore: BrewStore!
    var brewDetails: BrewDetails?

    @IBAction func cancelCreation(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveBrew(_ sender: UIBarButtonItem) {
        guard brewDetails != nil else {
            preconditionFailure("Brew Details expected to save a Brew.")
        }
        guard brewStore != nil else {
            preconditionFailure("BrewStore not available.")
        }

        let brewPickerRow = brewMethodPicker.selectedRow(inComponent: 0)
        let selectedBrewMethod = BrewMethod.allCases[brewPickerRow]
        var tastingValues: [String: TastingProperty] = [:]
        
        for tastingRating in brewDetails!.tasteRatings {
            tastingValues[tastingRating.name] = tastingRating.tasting
        }

        let currentBrew = Brew(brewMethod: selectedBrewMethod, grains: nil, coffee: brewDetails!.coffee, water: brewDetails!.water, duration: brewDetails?.time, brewScore: nil, creationDate: Date(), imageAddress: nil, aroma: tastingValues["Aroma"], acidity: tastingValues["Acidity"], sweetness: tastingValues["Sweetness"], body:  tastingValues["Body"], finish: tastingValues["Finish"], flavourNotes: nil, notes: brewDetails!.notes, grind: brewDetails!.grind)

        brewStore.saveBrew(brew: currentBrew)
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        brewMethodPicker.dataSource = self
        brewMethodPicker.delegate = self

        for child in self.children {
            if let tableViewDetails = child as? BrewDetails {
                brewDetails = tableViewDetails
            }
        }
    }

    @IBAction func chooseImage(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .automatic

        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            self.present(imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
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

extension NewBrewViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // UINavigationControllerDelegate, because UIImagePickerControllerDelegate delegate is inherited (?)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            brewPhotoImageView.image = image
            coffeeIcon.isHidden = true
            dismiss(animated: true, completion: nil)
        }
    }
}
