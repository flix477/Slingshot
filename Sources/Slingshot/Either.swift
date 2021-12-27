//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-22.
//

import Foundation

enum Either<L, R> {
    case right(R)
    case left(L)
}

extension Either {
    var left: L? {
        switch self {
        case .left(let x): return .pure(x)
        case .right: return .zero
        }
    }

    var right: R? {
        switch self {
        case .right(let x): return .pure(x)
        case .left: return .zero
        }
    }

    func consume(onLeft: @escaping (L) -> (), onRight: @escaping (R) -> ()) {
        switch self {
        case .left(let x): onLeft(x)
        case .right(let x): onRight(x)
        }
    }

    static func consume(onLeft: @escaping (L) -> (), onRight: @escaping (R) -> ()) -> (Either<L, R>) -> () {
        return { x in x.consume(onLeft: onLeft, onRight: onRight) }
    }
}

extension Either: Applicative {
    typealias ApplicativeA = R

    static func pure<T>(_ x: T) -> Either<L, T> {
        return .right(x)
    }

    static func ap<O>(rhs: Either<L, (R) -> O>, lhs: Either<L, R>) -> Either<L, O> where L: Semigroup {
        switch (rhs, lhs) {
        case (.right(let f), .right(let x)):
            return .pure(f(x))
        case (.right, .left(let e)):
            return .left(e)
        case (.left(let e), .right):
            return .left(e)
        case (.left(let e1), .left(let e2)):
            return .left(e1 <> e2)
        }
    }
}

extension Either: Functor {
    typealias FunctorValue = R

    func map<C>(_ transform: @escaping (R) -> C) -> Either<L, C> {
        switch self {
        case .right(let x):
            return .pure(transform(x))
        case .left(let x):
            return .left(x)
        }
    }


    static func !> <C>(lhs: Self, transform: @escaping (R) -> C) -> Either<L, C> {
        lhs.map(transform)
    }
}

extension Either: Bifunctor {
    typealias BifunctorA = L

    func mapLeft<C>(_ transform: @escaping (L) -> C) -> Either<C, R> {
        switch self {
        case .right(let x):
            return .right(x)
        case .left(let x):
            return .left(transform(x))
        }
    }

    func bimap<C, D>(onLeft: @escaping (L) -> C, onRight: @escaping (R) -> D) -> Either<C, D> {
        return map(onRight).mapLeft(onLeft)
    }
}

extension Either: Monad {
    typealias MonadA = R

    func flatMap<C>(_ binder: @escaping (R) -> Either<L, C>) -> Either<L, C> {
        switch self {
        case .right(let x):
            return binder(x)
        case .left(let x):
            return .left(x)
        }
    }

    static func |>> <C>(lhs: Self, rhs: @escaping (R) -> Either<L, C>) -> Either<L, C> {
        return lhs.flatMap(rhs)
    }
}

extension Either where L: Error {
    var result: Result<R, L> {
        switch self {
        case .right(let r):
            return .success(r)
        case .left(let l):
            return .failure(l)
        }
    }
}
