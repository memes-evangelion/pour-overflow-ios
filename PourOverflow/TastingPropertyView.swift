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

    @IBOutlet var quantityValue: UILabel!
    @IBOutlet var qualityValue: UILabel!

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
            quantityValue.textColor = newValue
            qualityValue.textColor = newValue
        }
    }

    @IBAction func firstSliderUpdate(_ sender: UISlider) {
        let integerValue = Int(sender.value)
        sender.setValue(Float(integerValue), animated: true)
        quantityValue.text = "\(integerValue)"
    }

    @IBAction func secondSliderUpdate(_ sender: UISlider) {
        let integerValue = Int(sender.value)
        sender.setValue(Float(integerValue), animated: true)
        qualityValue.text = "\(integerValue)"
    }


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
