//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-07-06.
//

import Foundation

precedencegroup SemigroupPrecedence {
    associativity: left
    higherThan: NilCoalescingPrecedence
}

infix operator <>: SemigroupPrecedence

protocol Semigroup {
    static func <> (lhs: Self, rhs: Self) -> Self
}
