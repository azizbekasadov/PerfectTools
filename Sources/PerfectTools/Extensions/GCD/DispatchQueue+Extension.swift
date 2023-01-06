//
//  DispatchQueue+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

public extension DispatchQueue {
    /// Выполняет блок на главной очереди если мы уже на ней или асинхронно на главной если мы не на ней.
    /// Нужен чтобы уменьшить вероятность гонки состояний.
    /// - Parameter execute: Closure to execute.
    public static func dispatchMainIfNeeded(_ execute: @escaping EmptyClosure) {
        guard self === DispatchQueue.main && Thread.isMainThread else {
            DispatchQueue.main.async(execute: execute)
            return
        }

        execute()
    }
}

public extension OperationQueue {
    /// Выполняет блок на главной очереди если мы уже на ней или асинхронно на главной если мы не на ней.
    /// Apple рекомендует использовать высокоуровневые методы для работы с асинхронностью.
    /// Использовать этот метод вместо привычного DispatchQueue.main `dispatchMainIfNeeded(_:)`.
    /// - Parameter execute: Closure to execute.
    public static func operationQueueMainIfNeed(_ execute: @escaping EmptyClosure) {
        guard self === DispatchQueue.main && Thread.isMainThread else {
            OperationQueue.main.addOperation(execute)
            return
        }
        
        execute()
    }
}
