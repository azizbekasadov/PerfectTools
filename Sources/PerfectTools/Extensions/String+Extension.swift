//
//  String+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

#if canImport(UIKit)
import UIKit.UIImage

extension String {
    public var image: UIImage {
        guard let image = UIImage(named: self) else {
            fatalError("Нет картинки для \(self)")
        }

        return image
    }

    public var base64Encoded: String {
        return Data(self.utf8).base64EncodedString()
    }
}

extension String {
    /// Достаёт метадату картинки в которой можно узнать её размеры не загружая её
    public func getImageSizeFromURL(completion: @escaping (CGSize?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let imageURL = URL(string: self),
                  let source = CGImageSourceCreateWithURL(imageURL as CFURL, nil),
                  let imageHeader = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) else { completion(nil); return }
            let imageHeaderDictionary = imageHeader as NSDictionary
            guard let width = imageHeaderDictionary["PixelWidth"] as? CGFloat,
                  let height = imageHeaderDictionary["PixelHeight"] as? CGFloat else { completion(nil); return }

            DispatchQueue.main.async {
                completion(CGSize(width: width, height: height))
            }
        }
    }
}

extension String {
    public var attributed: NSAttributedString {
        return NSAttributedString(string: self)
    }

    public var underlined: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}

#endif

extension String {
    /// Разделяет строку содержащую имя и фамилию на две части до первого пробела и после
    public func splitName() -> (firstName: String?, lastName: String?) {
        if self.count > 0 {
            let splittedNamesArray = self
                .split(separator: " ",
                       maxSplits: 1,
                       omittingEmptySubsequences: true)
                .map(String.init)
                .map { $0.trimmedSpacesAndLineBreaksWithDoubleSpaceFixing }
            if splittedNamesArray.count == 2 {
                return (splittedNamesArray[0], splittedNamesArray[1])
            }
            if splittedNamesArray.count == 1 {
                return (splittedNamesArray[0], nil)
            }
        }
        return (nil, nil)
    }

    /// Returns from " dummy  " -> " dummy".
    public var withoutTrailingSpaces: String {
        var s = self

        while s.hasSuffix(" ") {
            s = String(s.dropLast())
        }

        return s
    }

    public var trimmedSpaces: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    public var trimmedSpacesAndLineBreaks: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    public var trimmedSpacesAndLineBreaksWithDoubleSpaceFixing: String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }

    /// Форматированный телефон для карты (порт с прошлого проекта)
    public var formattedPhoneNumbers: String {
        let phoneNumbersArray = self.components(separatedBy: ", ")
        var resultString = ""

        for phone in phoneNumbersArray {
            let phoneWithoutSpaces = phone.cutSpaces

            if phoneWithoutSpaces.count > 20 {
                resultString.append("\(phoneWithoutSpaces.substring(to: 12))\n\(phoneWithoutSpaces.substring(from: 12))")
            } else {
                var tempString = ""
                let index = phoneNumbersArray.firstIndex(of: phone)
                if index != phoneNumbersArray.count - 1 {
                    tempString = "\(phoneWithoutSpaces)\n"
                } else {
                    tempString = "\(phoneWithoutSpaces)"
                }
                resultString.append(tempString)
            }
        }
        return resultString
    }

    public var dateISO6801: Date? {
        let formatter = ISO8601DateFormatter()
        var options: ISO8601DateFormatter.Options = .withInternetDateTime
        if self.isMatchingRegex(".+\\.\\d+Z") {
            options.insert(.withFractionalSeconds)
        }
        formatter.formatOptions = options

        if let date = formatter.date(from: self) {
            return date
        } else {
            print("Can't parse string to ISO8601.")
            return nil
        }
    }
}

extension String {
    public func updatedString(_ range: NSRange, _ replacementString: String) -> String {
        guard let stringRange = Range(range, in: self) else { return "" }
        return self.replacingCharacters(in: stringRange, with: replacementString)
    }
}

extension String {
    public var hasEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                0x1F680...0x1F6FF, // Transport and Map
                0x2600...0x26FF,   // Misc symbols
                0x2700...0x27BF,   // Dingbats
                0xFE00...0xFE0F,   // Variation Selectors
                0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                0x1F1E6...0x1F1FF: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }
}

extension Optional where Wrapped == String {
    public var nilIfEmpty: String? {
        if let self = self,
           self.isEmpty == false {
            return self
        } else {
            return nil
        }
    }

    public var isNilOrEmpty: Bool {
        self.nilIfEmpty == nil
    }
}

// MARK: - Cut

/**
 let str = "Hello, playground"
 print(str.substring(from: 7))         // playground
 print(str.substring(to: 5))           // Hello
 print(str.substring(with: 7..<11))    // play
 */
extension String {
    public var cutSpaces: String {
        return self.replacingOccurrences(of: " ", with: "")
    }

    public var cutHashtag: String {
        return self.replacingOccurrences(of: "#", with: "")
    }

    public func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    public func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    public func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    public func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        let range = startIndex..<endIndex
        return String(self[range])
    }
}

// MARK: - Validation

extension String {
    public var isValidEmail: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return isMatchingRegex(pattern)
    }

    public var isValidName: Bool {
        let pattern = "^[\\p{L} ]+$"
        return isMatchingRegex(pattern)
    }

    public var isValidNickname: Bool {
        // TODO: Add here a constant of the max characters usage
        let pattern = "^[a-zA-Z][a-zA-Z0-9-_\\.]{0,\(19)}$"
        return isMatchingRegex(pattern)
    }

    public var isValidPhone: Bool {
        let pattern = "^[0-9\\(\\)-+]+$"
        return isMatchingRegex(pattern)
    }

    public var isValidSearchString: Bool {
        return isValidNickname || isEmpty
    }

    public var isValidMultilanguageSearchString: Bool {
        let pattern = "^[\\p{L}0-9_-]*$"
        return isMatchingRegex(pattern)
    }

    public var isValidMultilanguageWithSpacesSearchString: Bool {
        let pattern = "^[\\p{L}0-9_ -]*$"
        return isMatchingRegex(pattern)
    }

    public func isMatchingRegex(_ regexPattern: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regexPattern).evaluate(with: self)
    }
}

extension String {
    /// Форматирование строки как номер телефона формата +# (###) ###-##-##
    public var formattedRussianPhoneNumber: String {
        applyPatternOnNumbers(pattern: "+# (###) ###-##-##", replacementCharacter: "#")
    }

    public var formattedGlobalPhoneNumber: String {
        applyPatternOnNumbers(pattern: "+####################", replacementCharacter: "#")
    }

    public var pureNumber: String {
        replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }

    private func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.pureNumber
        let numbersCount = pattern.filter { $0 == "#" }.count
        pureNumber = String(pureNumber.prefix(numbersCount))
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

extension String {
    /// Если строка начинается с арабского символа, то она отображается справо-налево независимо от semanticContentAttribute. Если поставить вначале этот символ то строка будет отображаться слева-направо.
    public static var leftToRightSymbol: String {
        return "\u{200E}"
    }
}
