//
//  Typealiases.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//


/**
 Used for the empty closure cases
 
 Essentially a shortcut for `func someAction(completion: EmptyClosure)`
*/
public typealias EmptyClosure = () -> Void


/**
 Used for the escaping and autoclosures cases where user adds some optional values as a input value
 
 Essentially a shortcut for `func someAction(action: Action<Bool>) -> Void`
 
 - Returns: Itself for chaining purposes
*/
public typealias Action<T> = (T) -> Void
