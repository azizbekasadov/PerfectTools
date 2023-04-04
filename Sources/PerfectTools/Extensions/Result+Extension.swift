//
//  Result+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension Result where Success == Void {
    public static var success: Self {
        return .success(Void())
    }
}
