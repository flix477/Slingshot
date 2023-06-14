//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

public extension Semigroup where Self: Numeric {
    static func <> (lhs: Self, rhs: Self) -> Self {
        lhs + rhs
    }
}

extension Int: Semigroup {}
extension UInt: Semigroup {}
extension Float: Semigroup {}
extension Double: Semigroup {}
