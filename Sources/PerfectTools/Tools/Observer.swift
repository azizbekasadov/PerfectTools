//
//  Observer.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

public final class Observer<T> {
    public typealias Listener = (T) -> Void
    /// Listener storage object
    private var listener: Listener?
    
    public var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    public init(_ value: T) {
        self.value = value
    }
    
    /// Added listener will be called, whenever the value changes
    public func bind(_ listener: @escaping Listener) {
        self.listener = listener
    }
    
    /// Added listener will be called, whenever the value changes and immediately after closure set
    public func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    public func removeBinders() {
        listener = nil
    }
}
