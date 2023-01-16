//
//  String+Trim+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension String {
    public func trim(to maximumCharacters: Int) -> String {
        return "\(self[..<index(startIndex, offsetBy: maximumCharacters)])" + "..."
    }
}
