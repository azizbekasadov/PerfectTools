//
//  NibLoader.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

#if canImport(UIKit)
import UIKit

public protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
}

// MARK: Default implementation

extension NibLoadable {
    /// By default, use the nib which have the same name as the name of the class,
    /// and located in the bundle of that class
    public static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

// MARK: Support for instantiation from NIB

extension NibLoadable where Self: UIView {
    /**
     Returns a `UIView` object instantiated from nib
     
     - returns: A `NibLoadable`, `UIView` instance
     */
    public static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}
#endif
