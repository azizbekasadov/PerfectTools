//
//  CGPoint+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

#if canImport(UIKit)
import UIKit

extension CGPoint {
    public func substract(point: CGPoint) -> CGPoint {
        return .init(x: x - point.x, y: y - point.y)
    }

    public func concate(point: CGPoint) -> CGPoint {
        return .init(x: x + point.x, y: y + point.y)
    }

    public func multiply(by multiplier: CGFloat) -> CGPoint {
        return .init(x: x * multiplier, y: y * multiplier)
    }

    public func concateYoffset(_ yOffset: CGFloat) -> CGPoint {
        return .init(x: x, y: y + yOffset)
    }
}
#endif
