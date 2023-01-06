//
//  Int+Extensions.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension Int64 {
    public var stringValue: String {
        return String(self)
    }

    public var boolValue: Bool {
        return self == 1
    }

    public var floatValue: CGFloat {
        return CGFloat(self)
    }
}


extension Int {
    public var stringValue: String {
        return String(self)
    }

    public var boolValue: Bool {
        return self == 1
    }

    public var floatValue: CGFloat {
        return CGFloat(self)
    }
}

extension NSNumber {
    fileprivate static let decimalFormatterWithSpace: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal

        var countryCode = "uz"//LocalizationService.default.currentLanguage.countryCode
        // для арабского делаем английскую локаль
        if countryCode.contains("ar") {
            countryCode = "en"
        }
        formatter.locale = Locale(identifier: countryCode)

        return formatter
    }()

    public var formattedWithSeparator: String {
        return NSNumber.decimalFormatterWithSpace.string(for: self) ?? ""
    }
}

extension Int {
    public var minimized: String {
        guard self > 1_000 else { return String(self) }

        let units: [String] = ["k", "m", "g", "t", "p", "e"]
        var num: Double = Double(self)
        num = fabs(num)
        let exp: Int = Int(log10(num) / 3.0 ) // log10(1000))
        let roundedNum: Double = round(10 * num / pow(1_000.0, Double(exp))) / 10

        if floor(roundedNum) == roundedNum {
            return "\(Int(roundedNum))\(units[exp - 1])"
        }

        return "\(roundedNum)\(units[exp - 1])"
    }
}
