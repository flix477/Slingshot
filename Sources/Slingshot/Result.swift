//
//  Result.swift
//  
//
//  Created by Felix Leveille on 2021-12-27.
//

import Foundation

extension Result {
    var either: Either<Failure, Success> {
        switch self {
        case .success(let x): return .right(x)
        case .failure(let error): return .left(error)
        }
    }

    func consume(onSuccess: @escaping (Success) -> (), onFailure: @escaping (Failure) -> ()) {
        switch self {
        case .success(let x): onSuccess(x)
        case .failure(let x): onFailure(x)
        }
    }

    func consume(onSuccess: @escaping (Success) -> (), onFailure: @escaping (Failure) -> ()) -> (Result<Success, Failure>) -> () {
        { x in x.consume(onSuccess: onSuccess, onFailure: onFailure) }
    }
}

extension Result: Applicative {
    typealias ApplicativeA = Success

    static func pure<T>(_ x: T) -> Result<T, Failure> {
        return .success(x)
    }

    static func ap<O>(rhs: Result<(Success) -> O, Failure>, lhs: Result<Success, Failure>) -> Result<O, Failure> where Failure: Semigroup {
        switch (rhs, lhs) {
        case (.success(let f), .success(let x)):
            return .pure(f(x))
        case (.success, .failure(let e)):
            return .failure(e)
        case (.failure(let e), .success):
            return .failure(e)
        case (.failure(let e1), .failure(let e2)):
            return .failure(e1 <> e2)
        }
    }
}

extension Result: Functor {
    typealias FunctorValue = Success

    func map<C>(_ transform: @escaping (Success) -> C) -> Result<C, Failure> {
        switch self {
        case .success(let x):
            return .pure(transform(x))
        case .failure(let x):
            return .failure(x)
        }
    }


    static func !> <C>(lhs: Self, transform: @escaping (Success) -> C) -> Result<C, Failure> {
        lhs.map(transform)
    }
}

extension Result: Bifunctor {
    typealias BifunctorA = Failure

    func mapLeft<C>(_ transform: @escaping (Failure) -> C) -> Result<Success, C> {
        switch self {
        case .success(let x):
            return .success(x)
        case .failure(let x):
            return .failure(transform(x))
        }
    }

    func bimap<C, D>(onLeft: @escaping (Failure) -> C, onRight: @escaping (Success) -> D) -> Result<D, C> {
        return map(onRight).mapLeft(onLeft)
    }
}

extension Result: Monad {
    typealias MonadA = Success

    func flatMap<C>(_ binder: @escaping (Success) -> Result<C, Failure>) -> Result<C, Failure> {
        switch self {
        case .success(let x):
            return binder(x)
        case .failure(let x):
            return .failure(x)
        }
    }

    static func |>> <C>(lhs: Self, rhs: @escaping (Success) -> Result<C, Failure>) -> Result<C, Failure> {
        return lhs.flatMap(rhs)
    }
}
