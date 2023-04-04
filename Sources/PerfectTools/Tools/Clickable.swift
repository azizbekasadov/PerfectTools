//
//  File.swift
//  
//
//  Created by Azizbek Asadov on 04/04/23.
//

import Foundation
import ObjectiveC

#if canImport(UIKit)
import UIKit

public protocol Clickable {
    var tapAction: () -> Void { get set }
    var longPressAction: () -> Void { get set }
    
    func addTapGesture(tapAction: @escaping () -> Void) -> Void
    func addLongPressGesture(duration: Double, longPressAction: @escaping () -> Void) -> Void
    func handleTap(sender: UITapGestureRecognizer) -> Void
    func handleLongPress(sender: UILongPressGestureRecognizer)
}

public extension UIView: Clickable {
    
    private static var _tapAction = [String:(() -> Void)]()
    private static var _longPressAction = [String:(() -> Void)]()
    
    // Declare a global var to produce a unique address as the associated object handle
    private static var tapActionObjectHandle: UInt8 = 0
    private static var longPressActionObjectHandle: UInt8 = 1
    
    var tapAction: () -> Void {
        get {
            return objc_getAssociatedObject(self, &UIView.tapActionObjectHandle) as! (() -> Void)
        }
        set {
            objc_setAssociatedObject(self, &UIView.tapActionObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var longPressAction: () -> Void {
        get {
            return objc_getAssociatedObject(self, &UIView.longPressActionObjectHandle) as! (() -> Void)
        }
        set {
            objc_setAssociatedObject(self, &UIView.longPressActionObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Handle tap
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.tapAction()
    }
    
    /// Handle long press
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            self.longPressAction()
        }
    }
    
    /// Tap gesture
    func addTapGesture(tapAction: @escaping () -> Void) {
        let tap = UITapGestureRecognizer(target: self , action: #selector(self.handleTap(sender:)))
        self.tapAction = tapAction
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    /// Long press
    func addLongPressGesture(duration: Double = 0.5, longPressAction: @escaping () -> Void) {
        let longPress = UILongPressGestureRecognizer(target: self , action: #selector(self.handleLongPress(sender:)))
        self.longPressAction = longPressAction
        longPress.minimumPressDuration = duration
        longPress.delaysTouchesBegan = true
        self.addGestureRecognizer(longPress)
        self.isUserInteractionEnabled = true
    }
}

#endif
