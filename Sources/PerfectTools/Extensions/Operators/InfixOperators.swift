//
//  File.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

// MARK: - Assign if not nil
infix operator ?= : AssignmentPrecedence

/// Проверяет на nil. Если не nil тогда выполняет =. Если nil, тогда ничего не делает.
public func ?= <T>(target: inout T, newValue: T?) {
    if let unwrapped = newValue {
        target = unwrapped
    }
}
