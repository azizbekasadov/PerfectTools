//
//  WeakBox.swift
//  
//
//  Created by Azizbek Asadov on 08/01/23.
//

import Foundation

public final class WeakBox<T: AnyObject> {
    public  weak var object: T?
    
    public init (_ object: T) {
        self.object = object
    }
}

extension WeakBox: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }

    public static func == (lhs: WeakBox<T>, rhs: WeakBox<T>) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
