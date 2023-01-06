//
//  CustomDebugStringConvertible+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension CustomDebugStringConvertible {
    public var debugDescription: String {
        var debugString = "***** \(type(of: self)) *****\n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                debugString += "\(propertyName): \(child.value)\n"
            }
        }
        return debugString
    }
}
