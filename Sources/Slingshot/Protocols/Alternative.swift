//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-22.
//

import Foundation

protocol Alternative {
    func alt(_ x: Self) -> Self
}

precedencegroup AlternativePrecedence {
    associativity: left
    higherThan: FunctorPrecedence
}

infix operator <||>: AlternativePrecedence

func <||> <T: Alternative>(lhs: T, rhs: T) -> T {
    return lhs.alt(rhs)
}

extension Alternative where Self: BoolCoercible {
    func alt(_ x: Self) -> Self {
        return bool ? self : x
    }
}

extension Dictionary: Alternative {}
extension String: Alternative {}
extension Int: Alternative {}
extension Double: Alternative {}
