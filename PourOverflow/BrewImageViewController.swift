//
//  BrewImageViewController.swift
//  PourOverflow
//
//  Created by marto on 05/02/21.
//

import UIKit

class BrewImageViewController: UIViewController {
    @IBOutlet var brewImageView: UIImageView!

    var brewImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        brewImageView.image = brewImage
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
