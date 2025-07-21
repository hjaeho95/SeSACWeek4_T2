import UIKit

class PaddingUILabel: UILabel {
    var padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}
