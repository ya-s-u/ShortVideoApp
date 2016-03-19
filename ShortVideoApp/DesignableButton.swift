import UIKit

@IBDesignable class DesignableButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0

    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.blackColor()


    override func drawRect(rect: CGRect) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = (cornerRadius > 0)

        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.CGColor
    }
}
