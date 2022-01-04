//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

public protocol Monoid: Semigroup, Zero {}

public extension Monoid {
    static func concat(values: [Self]) -> Self {
        values.reduceFromZero { a, b in a <> b }
    }
}

extension Array: Monoid {}
extension Bool: Monoid {}
extension Double: Monoid {}
extension String: Monoid {}
extension Set: Monoid {}
extension Int: Monoid {}

extension Optional: Monoid where Wrapped: Semigroup {}
