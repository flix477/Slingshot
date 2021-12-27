//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-07-10.
//

import Foundation

protocol Filterable {
    associatedtype FilterableA

    func filter(_ shouldKeep: @escaping (FilterableA) -> Bool) -> Self
}

extension Filterable where Self: Semigroup, Self: Zero, Self: Applicative, Self: Foldable, FilterableA == FoldableA, FilterableA == ApplicativeA {
    func filter(_ shouldKeep: @escaping (FilterableA) -> Bool) -> Self where Self == ApplicativeB {
        return fold { acc, value in
            if shouldKeep(value) {
                return acc <> .pure(value)
            }

            return acc
        }
    }
}
