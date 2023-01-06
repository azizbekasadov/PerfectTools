//
//  Collection+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension Optional where Wrapped: Collection, Wrapped.Element: Hashable {
    public func transformToSet() -> Set<Wrapped.Element>? {
        if let self = self {
            return Set(self)
        } else {
            return nil
        }
    }
}

extension Collection where Element: Hashable {
    public func transformToSet() -> Set<Element> {
        return Set(self)
    }
}
