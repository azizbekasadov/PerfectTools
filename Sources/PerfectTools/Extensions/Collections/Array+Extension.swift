//
//  Array+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension Array where Element: Equatable {
    public func removeDuplicates() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}

extension Array {
    public var zero: Array {
        return [Element]()
    }
}

extension Array {
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element == String? {
    public func compactConcate(separator: String) -> String {
        return self.compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: separator)
    }
}

extension Array where Element == CGPoint {
    public var firstPoint: CGPoint {
        return sortedPoints.first ?? .zero
    }

    public var lastPoint: CGPoint {
        return sortedPoints.last ?? .zero
    }

    // Выстраиваем точки слева направо
    public var sortedPoints: [CGPoint] {
        return self.sorted { $0.x < $1.x }
    }
}
