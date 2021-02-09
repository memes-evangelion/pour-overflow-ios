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
    @IBOutlet weak var propertyTitle: UILabel!

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!

    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondSlider: UISlider!

    @IBInspectable
    var title: String? {
        get {
            return propertyTitle.text
        }
        set {
            propertyTitle.text = newValue
        }
    }

    @IBInspectable
    var firstTitle: String? {
        get {
            return firstLabel.text
        }
        set {
            firstLabel.text = newValue
        }
    }

    @IBInspectable
    var secondTitle: String? {
        get {
            return secondLabel.text
        }
        set {
            secondLabel.text = newValue
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return contentView.layer.cornerRadius
        }
        set {
            contentView.layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var viewBackgroundColor: UIColor? {
        get {
            return contentView.backgroundColor
        }
        set {
            contentView.backgroundColor = newValue
        }
    }

    @IBInspectable
    var textTintColor: UIColor? {
        get {
            return propertyTitle.textColor
        }
        set {
            propertyTitle.textColor = newValue
            firstLabel.textColor = newValue
            secondLabel.textColor = newValue
            firstSlider.tintColor = newValue
            secondSlider.tintColor = newValue
        }
    }

    func createNib() {
        let nib = UINib(nibName: "TastingPropertyView", bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
    }

    func setSlider(slider: UISlider) {
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.isContinuous = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createNib()
        setSlider(slider: firstSlider)
        setSlider(slider: secondSlider)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createNib()
        setSlider(slider: firstSlider)
        setSlider(slider: secondSlider)
    }
}
