//
//  Predicate.swift
//  
//
//  Created by Felix Leveille on 2022-11-18.
//

import Foundation

public typealias Predicate<T> = (T) -> Bool

public func not<T>(_ predicate: @escaping Predicate<T>) -> Predicate<T> {
    { !predicate($0) }
}

public func && <T>(lhs: @escaping Predicate<T>, rhs: @escaping Predicate<T>) -> Predicate<T> {
    { lhs($0) && rhs($0) }
}

public func || <T>(lhs: @escaping Predicate<T>, rhs: @escaping Predicate<T>) -> Predicate<T> {
    { lhs($0) || rhs($0) }
}
