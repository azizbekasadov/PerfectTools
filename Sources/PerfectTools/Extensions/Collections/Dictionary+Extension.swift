//
//  Dictionary+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension Dictionary {
    public static func += <K, V> (left: inout [K: V], right: [K: V]) {
        for (k, v) in right {
            left[k] = v
        }
    }
}

extension Dictionary where Key: CustomDebugStringConvertible, Value: CustomDebugStringConvertible {
    public var prettyPrint: String {
        for (key, value) in self {
            print("\(key) = \(value)")
        }

        return self.description
    }
}
