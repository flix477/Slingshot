//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-22.
//

import Foundation

precedencegroup FunctorPrecedence {
    associativity: left
    higherThan: MonadicFlatMapPrecedence
}

infix operator !>: FunctorPrecedence

protocol Functor {
    associatedtype FunctorValue
    associatedtype FunctorB: Functor = Self

    static func map<C>(_ transform: @escaping (FunctorValue) -> C) -> (Self) -> FunctorB where FunctorB.FunctorValue == C
    func map<C>(_ transform: @escaping (FunctorValue) -> C) -> FunctorB where FunctorB.FunctorValue == C
    static func !> <C>(lhs: Self, transform: @escaping (FunctorValue) -> C) -> FunctorB where FunctorB.FunctorValue == C
}

extension Functor {
    static func map<C>(_ transform: @escaping (FunctorValue) -> C) -> (Self) -> FunctorB where FunctorB.FunctorValue == C {
        return { $0.map(transform) }
    }
}
