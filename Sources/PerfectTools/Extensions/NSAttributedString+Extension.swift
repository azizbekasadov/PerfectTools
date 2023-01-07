//
//  NSAttributedString+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//


#if canImport(UIKit)
import UIKit

extension NSAttributedString {
    // Вероятно boundingRect: - работает не идеально. Не отнимает lineSpacing последней строки.
    public func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }
}

extension NSAttributedString {
    public var attributes: [NSAttributedString.Key: Any] {
        guard !string.isEmpty else { return [:] }

        var range = NSRange(location: 0, length: 0)
        return self.attributes(at: 0, effectiveRange: &range)
    }
}
#endif
