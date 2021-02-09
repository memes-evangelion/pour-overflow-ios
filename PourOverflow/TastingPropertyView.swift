//
//  TastingPropertyView.swift
//  PourOverflow
//
//  Created by marto on 08/02/21.
//

import UIKit

@IBDesignable
class TastingPropertyView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var propertyTitle: UILabel!

    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!

    @IBOutlet var firstSlider: UISlider!
    @IBOutlet var secondSlider: UISlider!

    func createNib() {
        let nib = UINib(nibName: "TastingPropertyView", bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createNib()

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createNib()
    }
}
