import UIKit

@IBDesignable class DesignableView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0.0

    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.blackColor()

    @IBInspectable var borderTop: Bool = false
    @IBInspectable var borderBottom: Bool = false
    @IBInspectable var borderLeft: Bool = false
    @IBInspectable var borderRight: Bool = false

    override func drawRect(rect: CGRect) {
        layer.masksToBounds = true
        clipsToBounds = (cornerRadius > 0)

        let context = UIGraphicsGetCurrentContext()
        let lineWidth = borderWidth / UIScreen.mainScreen().scale

        CGContextSetFillColorWithColor(context, backgroundColor?.CGColor)
        CGContextFillRect(context, rect)

        CGContextSetStrokeColorWithColor(context, borderColor.CGColor)
        CGContextSetLineWidth(context, lineWidth)

        if borderTop && borderBottom && borderLeft && borderRight {
            layer.borderColor = borderColor.CGColor
            layer.borderWidth = borderWidth / UIScreen.mainScreen().scale
            return
        }

        if borderTop {
            CGContextMoveToPoint(context, 0, 0)
            CGContextAddLineToPoint(context, rect.width, 0)
            CGContextStrokePath(context)
        }

        if borderBottom {
            CGContextMoveToPoint(context, 0, rect.height)
            CGContextAddLineToPoint(context, rect.width, rect.height)
            CGContextStrokePath(context)
        }

        if borderLeft {
            CGContextMoveToPoint(context, 0, 0)
            CGContextAddLineToPoint(context, 0, rect.height)
            CGContextStrokePath(context)
        }

        if borderRight {
            CGContextMoveToPoint(context, rect.width, 0)
            CGContextAddLineToPoint(context, rect.width, rect.height)
            CGContextStrokePath(context)
        }
    }
}