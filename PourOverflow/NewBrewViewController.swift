//
//  NewBrewViewController.swift
//  PourOverflow
//
//  Created by marto on 06/01/21.
//

import UIKit

class NewBrewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!

    var brewStore: BrewStore!
    
    // For taking the photo   
    @IBAction func choosePhotoSource(_ sender: UIButton) {
        // Create alert
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // Add camera if available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { _ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        // Add photo from library
        let photoLibraryAction = UIAlertAction(title: "Photos", style: .default, handler: { _ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            self.present(imagePicker, animated: true, completion: nil)
        })
        alertController.addAction(photoLibraryAction)
        // cancel
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
}
