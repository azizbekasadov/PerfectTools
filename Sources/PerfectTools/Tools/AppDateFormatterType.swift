//
//  AppDateFormatterType.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

public enum AppDateFormatterType {
    /// 20 february 2017, 00:00
    case dayMonthYearTime

    /// 20 february, 00:00
    case dayMonthTime

    /// 07.04.2017
    case dayMonthYearShort

    /// 07.04.2017, 00:00
    case dayMonthYearShortTime

    /// 10 Февраля
    case dayMonth

    /// 20:40
    case hourMinute

    /// 10:59
    case minuteSecond

    /// 20:40:10.043
    case timeWithMilliseconds
}

public protocol AppDateFormatterServiceInterface {
    /// Получить форматтер
    func getFormatter(type: AppDateFormatterType) -> DateFormatter

    /// Установить новый язык для форматтеров. Берётся из текущей локали.
    /// Вызывается например при смене языка.
    /// - Parameters:
    ///     - countryCode: `String` код страны или же isoCode локали
    func updateLocale(countryCode: String)
}

/// Создание форматтеров - затратная операция, поэтом создаём их один раз и в случае надобности устанавливаем локаль.
/// https://sarunw.com/posts/how-expensive-is-dateformatter/
public final class AppDateFormatterService {
    public static let shared: AppDateFormatterServiceInterface = AppDateFormatterService()

    private var dayMonthYearTimeFormatter: DateFormatter
    private var dayMonthTimeFormatter: DateFormatter
    private var dayMonthYearShortFormatter: DateFormatter
    private var dayMonthYearShortTimeFormatter: DateFormatter
    private var dayMonthFormatter: DateFormatter
    private var hourMinuteFormatter: DateFormatter
    private var minuteSecondFormatter: DateFormatter
    private var timeWithMillisecondsFormatter: DateFormatter

    private init() {
        dayMonthYearTimeFormatter = DateFormatter()
        dayMonthYearTimeFormatter.dateFormat = "d MMMM yyyy, HH:mm"

        dayMonthTimeFormatter = DateFormatter()
        dayMonthTimeFormatter.dateFormat = "d MMMM, HH:mm"

        dayMonthYearShortFormatter = DateFormatter()
        dayMonthYearShortFormatter.dateFormat = "dd.MM.yyyy"

        dayMonthYearShortTimeFormatter = DateFormatter()
        dayMonthYearShortTimeFormatter.dateFormat = "dd.MM.yyyy HH:mm"

        dayMonthFormatter = DateFormatter()
        dayMonthFormatter.dateFormat = "d MMMM"

        hourMinuteFormatter = DateFormatter()
        hourMinuteFormatter.dateFormat = "HH:mm"

        minuteSecondFormatter = DateFormatter()
        minuteSecondFormatter.dateFormat = "mm:ss"

        timeWithMillisecondsFormatter = DateFormatter()
        timeWithMillisecondsFormatter.dateFormat = "HH:mm:ss.SSS"

        updateLocale()
    }

    private func getLocale(countryCode: String = "en") -> Locale {
        var _countryCode = countryCode

        // для арабского делаем английскую локаль
        if countryCode.contains("ar") {
            _countryCode = "en"
        }

        return Locale(identifier: _countryCode)
    }
}

extension AppDateFormatterService: AppDateFormatterServiceInterface {
    public func getFormatter(type: AppDateFormatterType) -> DateFormatter {
        switch type {
        case .dayMonthYearTime:
            return dayMonthYearTimeFormatter
        case .dayMonthTime:
            return dayMonthTimeFormatter
        case .dayMonthYearShort:
            return dayMonthYearShortFormatter
        case .dayMonthYearShortTime:
            return dayMonthYearShortTimeFormatter
        case .dayMonth:
            return dayMonthFormatter
        case .hourMinute:
            return hourMinuteFormatter
        case .minuteSecond:
            return minuteSecondFormatter
        case .timeWithMilliseconds:
            return timeWithMillisecondsFormatter
        }
    }

    public func updateLocale(countryCode: String = "en") {
        let locale = getLocale(countryCode: countryCode)

        dayMonthYearTimeFormatter.locale = locale
        dayMonthTimeFormatter.locale = locale
        dayMonthYearShortFormatter.locale = locale
        dayMonthYearShortTimeFormatter.locale = locale
        dayMonthFormatter.locale = locale
        hourMinuteFormatter.locale = locale
        timeWithMillisecondsFormatter.locale = locale
    }
}
