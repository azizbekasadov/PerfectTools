//
//  Double+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension Double {
    public var stringValue: String {
        return String(self)
    }

    public var intValue: Int {
        Int(self)
    }

    public var date: Date {
        return Date(timeIntervalSince1970: self)
    }
}

extension Double {
    public func priceStringWithCurrencySymbolIfExist(for currencySymbol: String) -> String {
        var finalString = String(NSNumber(floatLiteral: self).formattedWithSeparator)
        finalString.append(currencySymbol)
        return finalString
    }
}
