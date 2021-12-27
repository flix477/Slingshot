//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-22.
//

import Foundation

extension Optional: Zero {
    static var zero: Optional {
        return .none
    }
}

extension Optional: BoolCoercible {
    var bool: Bool {
        switch self {
        case .some: return true
        case .none: return false
        }
    }
}

extension Optional: Alternative {}

extension Optional: Functor {
    typealias FunctorValue = Wrapped

    func map<C>(_ transform: @escaping (FunctorValue) -> C) -> C? {
        switch self {
        case .some(let x):
            return .pure(transform(x))
        case .none:
            return .zero
        }
    }

    static func !> <C>(lhs: Self, transform: @escaping (Wrapped) -> C) -> C? {
        lhs.map(transform)
    }
}

extension Optional: Applicative {
    typealias ApplicativeA = Wrapped

    static func pure(_ x: Wrapped) -> Wrapped? {
        return .some(x)
    }

    static func ap<O>(lhs: ((Wrapped) -> O)?, rhs: Self) -> O? {
        switch (lhs, rhs) {
        case (.some(let f), .some(let x)):
            return f(x)
        default:
            return .zero
        }
    }

    func apLeft<O>(rhs: O?) -> Self {
        switch (self, rhs) {
        case (.some(let x), .some):
            return x
        default:
            return .zero
        }
    }

    func apRight<O>(rhs: O?) -> O? {
        switch (self, rhs) {
        case (.some, .some(let x)):
            return x
        default:
            return .zero
        }
    }
}

extension Optional: Monad {
    typealias MonadA = Wrapped

    func flatMap<C>(_ transform: @escaping (Wrapped) -> C?) -> C? {
        switch self {
        case .none:
            return .zero
        case .some(let wrapped):
            return transform(wrapped)
        }
    }

    static func |>> <C>(lhs: Wrapped?, rhs: @escaping (Wrapped) -> C?) -> C? {
        lhs.flatMap(rhs)
    }
}

extension Optional: Foldable {
    typealias FoldableA = Wrapped

    func fold<T>(initial: T, folder: (T, Wrapped) -> T) -> T {
        switch self {
        case .some(let x):
            return folder(initial, x)
        case .none:
            return initial
        }
    }
}

extension Optional: Filterable {
    typealias FilterableA = Wrapped

    func filter(_ shouldKeep: @escaping (Wrapped) -> Bool) -> Wrapped? {
        switch self {
        case .some(let x):
            return shouldKeep(x) ? .pure(x) : .zero
        case .none:
            return .zero
        }
    }
}

extension FloatingPoint {
    func safeDivide(_ other: Self) -> Self? {
        if other == 0 {
            return .zero
        }

        return .pure(self / other)
    }
}
