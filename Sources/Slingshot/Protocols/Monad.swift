//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-23.
//

import Foundation

precedencegroup MonadicFlatMapPrecedence {
    associativity: left
}

infix operator |>>: MonadicFlatMapPrecedence

protocol Monad: Applicative {
    associatedtype MonadA
    associatedtype MonadB: Monad = Self

    func flatMap<C>(_ transform: @escaping (MonadA) -> MonadB) -> MonadB where MonadB.MonadA == C
    static func flatMap<C>(_ transform: @escaping (MonadA) -> MonadB) -> (Self) -> MonadB where MonadB.MonadA == C
    static func |>> <C>(lhs: Self, rhs: @escaping (MonadA) -> MonadB) -> MonadB where MonadB.MonadA == C
}

extension Monad {
    static func flatMap<C>(_ transform: @escaping (MonadA) -> MonadB) -> (Self) -> MonadB where MonadB.MonadA == C {
        return { $0.flatMap(transform) }
    }
}
