//
//  HashtagChecker.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

public class HashtagChecker {
    /// Текущий хэштэг, на котором стоит курсор
    public var currentHashtagResult: NSTextCheckingResult?

    private let hashtagRegexDetector = try? NSRegularExpression(pattern: "#\\w*", options: .caseInsensitive)

    /// Проверяет входит ли range в какой либо хэштэг в строке и если да, то записывает его в currentHashtagResult
    public func checkIfEditingHashtag(text: String, range: NSRange) {
        // Получаем диапазоны хэштэгов в textView
        let hashtagRanges = self.rangesOfHashtagsInString(text)

        if hashtagRanges.count > 0 {
            for hashtag in hashtagRanges {
                // Проверка пересекает ли текущий диапазон какой-либо хэштэг. Нужно добавить + 1 для того чтобы понять если ты в конце хэштэга, пока NSLocationInRange использует < вместо <=.
                let currentlyTypingHashtagRange = NSRange(location: hashtag.range.location, length: hashtag.range.length + 1)
                if NSLocationInRange(range.location, currentlyTypingHashtagRange) {
                    // Если курсор над, то запоминаем
                    currentHashtagResult = hashtag
                } else {
                    currentHashtagResult = nil
                }
            }
        } else {
            currentHashtagResult = nil
        }
    }

    /// Возвращает список диапазонов хэштэгов в строке
    public func rangesOfHashtagsInString(_ string: String) -> [NSTextCheckingResult] {
        let hashtagRanges = hashtagRegexDetector?.matches(in: string,
                                                          options: .withoutAnchoringBounds,
                                                          range: NSRange(string.startIndex..., in: string))
        return hashtagRanges ?? []
    }

    /// Количество хэштэгов в строке
    public func numberOfHashtagsInString(_ string: String) -> Int {
        let numberOfHashtags = hashtagRegexDetector?.numberOfMatches(in: string,
                                                                     options: .withoutAnchoringBounds,
                                                                     range: .init(location: 0,
                                                                                  length: string.count))
        return numberOfHashtags ?? 0
    }

    /// Конвертирует текущий результат в текст
    public func stringWithResult(from text: String) -> String? {
        guard let result = currentHashtagResult else {
            return nil
        }

        let nsString = text as NSString
        return nsString.substring(with: result.range)
    }
}
