//
//  CALayer+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//


#if canImport(UIKit)
import UIKit

extension CALayer {
    /// `applyFigmaShadow` used for the application of the shadows of the same style as it could be done in Figma;
    /// Better invoke this method in `layoutSubviews`, since the `shadowPath` is drawn with bounds value that is set in this method
    public func applyFigmaShadow(color: UIColor,
                             alpha: Float,
                             xValue: CGFloat,
                             yValue: CGFloat,
                             blur: CGFloat,
                             spread: CGFloat) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: yValue, height: yValue)
        shadowRadius = blur / UIScreen.main.scale

        let _dx = -spread
        let rect = bounds.insetBy(dx: _dx, dy: _dx)
        if cornerRadius != 0 {
            shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        } else {
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
#endif
