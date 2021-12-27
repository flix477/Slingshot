//
//  File.swift
//
//
//  Created by Felix Leveille on 2021-06-22.
//

import Foundation

protocol Bifunctor: Functor {
    associatedtype BifunctorA
    associatedtype BifunctorB: Bifunctor = Self

    func mapLeft<C>(_ transform: @escaping (BifunctorA) -> C) -> BifunctorB where BifunctorB.BifunctorA == C
    func bimap<C, D>(onLeft: @escaping (BifunctorA) -> C,
                     onRight: @escaping (FunctorValue) -> D) -> BifunctorB where BifunctorB.BifunctorA == C, FunctorB.FunctorValue == D
}
