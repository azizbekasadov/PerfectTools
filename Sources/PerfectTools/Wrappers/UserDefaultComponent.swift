//
//  UserDefault.swift
//
//
//  Created by Azizbek Asadov on 07/01/23.
//

import Foundation

public protocol UDComponent {
    associatedtype Value
    
    func getFromUserDefaults(key: String) -> Value?
    func saveToUserDefaults(value: Value?, name: String, key: String)
}
