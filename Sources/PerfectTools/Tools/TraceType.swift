//
//  TraceType.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

/**
 Logs & traces all necessary events in the app
 
 Essentially a shortcut for `trace("Some event", type: .debug)`
 
 - Returns: Itself for chaining purposes
*/
public enum TraceType: String {
    case success = "✅"
    case yeah = "🔥"
    case nice = "🏖️"
    case debug = "🗿"
    case warning = "⚠️"
    case error = "❌"
}

@discardableResult
public func trace(_ description: String,
           type: TraceType = .debug,
           fileName: String = #file,
           lineNumber: Int = #line,
           functionName: String = #function) -> String {
    let traceString = "\(type.rawValue) \(fileName.components(separatedBy: "/").last!) -> \(functionName) -> \(description) (line: \(lineNumber))"
    print(traceString)
    return traceString
}
