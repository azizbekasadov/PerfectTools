//
//  File.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension Bool {
    public var intValue: Int {
        return self ? 1 : 0
    }

    public var floatValue: CGFloat {
        return self ? 1.0 : 0.0
    }
}

extension Optional where Wrapped == Bool {
    public var stringWord: String? {
        guard let self = self else { return nil }
        return String(self)
    }
}

