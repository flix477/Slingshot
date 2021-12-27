//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-12-27.
//

import Foundation

extension Array: Functor {
    typealias FunctorValue = Element

    func map<C>(_ transform: @escaping (Element) -> C) -> [C] {
        var result: [C] = []
        for x in self {
            result.append(transform(x))
        }

        return result
    }

    static func !> <C>(lhs: [Element], transform: @escaping (Element) -> C) -> [C] {
        lhs.map(transform)
    }
}

extension Array: Applicative {
    typealias ApplicativeA = Element

    static func pure<T>(_ x: T) -> [T] {
        [x]
    }
}

extension Array: Monad {
    typealias MonadA = Element

    func flatMap<C>(_ transform: @escaping (Element) -> [C]) -> [C] {
        var result: [C] = []
        for x in self {
            result.append(contentsOf: transform(x))
        }

        return result
    }

    static func |>> <C>(lhs: Array<Element>, rhs: @escaping (Element) -> [C]) -> [C] {
        lhs.flatMap(rhs)
    }
}

extension Array: Foldable {
    typealias FoldableA = Element

    func fold<T>(initial: T, folder: @escaping (T, Element) -> T) -> T {
        reduce(initial, folder)
    }
}

extension Array: Semigroup {
    static func <> (lhs: Array<Element>, rhs: Array<Element>) -> Array<Element> {
        return lhs + rhs
    }
}

extension Array: Filterable {
    typealias FilterableA = Element

    func filter(_ shouldKeep: @escaping (Element) -> Bool) -> [Element] {
        var results: [Element] = []
        for x in self where shouldKeep(x) {
            results.append(x)
        }

        return results
    }
}

extension Array: BoolCoercible {
    var bool: Bool { isEmpty }
}

extension Array: Zero {
    static var zero: Array { [] }
}

extension Array: Alternative {}
