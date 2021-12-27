//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-08-02.
//

import Foundation

enum Validation<Failure, Value> {
    case success(Value)
    case failure(NonEmptyCons<Failure>)
}

extension Validation {
    static func fail(_ error: Failure) -> Validation<Failure, Value> {
        return .failure(.pure(error))
    }

    func fail(_ error: Failure) -> Validation<Failure, Value> {
        let error: NonEmptyCons<Failure> = .pure(error)
        switch self {
        case .success:
            return .failure(error)
        case .failure(let failures):
            return .failure(failures <> error)
        }
    }

    var either: Either<NonEmptyCons<Failure>, Value> {
        switch self {
        case .success(let x): return .right(x)
        case .failure(let failures): return .left(failures)
        }
    }

    var failures: Cons<Failure> {
        switch self {
        case .success: return .zero
        case .failure(let xs): return xs.cons
        }
    }

    var value: Value? {
        return either.right
    }
}

extension Validation: Functor {
    typealias FunctorValue = Value

    func map<C>(_ transform: @escaping (Value) -> C) -> Validation<Failure, C> {
        switch self {
        case .success(let x):
            return .success(transform(x))
        case .failure(let failures):
            return .failure(failures)
        }
    }

    static func !> <C>(lhs: Validation<Failure, Value>, transform: @escaping (Value) -> C) -> Validation<Failure, C> {
        return lhs.map(transform)
    }
}

extension Validation: Applicative {
    typealias ApplicativeA = Value

    static func pure<T>(_ x: T) -> Validation<Failure, T> {
        return .success(x)
    }

    static func ap<O>(lhs: Validation<Failure, (Value) -> O>, rhs: Validation<Failure, Value>) -> Validation<Failure, O> {
        switch (lhs, rhs) {
        case (.success(let f), .success(let x)):
            return .success(f(x))
        case (.success, .failure(let failures)):
            return .failure(failures)
        case (.failure(let failures), .success):
            return .failure(failures)
        case (.failure(let f1), .failure(let f2)):
            return .failure(f1 <> f2)
        }
    }

    func apLeft<O>(_ rhs: Validation<Failure, O>) -> Self {
        switch (self, rhs) {
        case (.success(let x), .success):
            return .success(x)
        case (.success, .failure(let failures)):
            return .failure(failures)
        case (.failure(let failures), .success):
            return .failure(failures)
        case (.failure(let f1), .failure(let f2)):
            return .failure(f1 <> f2)
        }
    }

    func apRight<O>(_ rhs: Validation<Failure, O>) -> Validation<Failure, O> {
        switch (self, rhs) {
        case (.success, .success(let x)):
            return .success(x)
        case (.success, .failure(let failures)):
            return .failure(failures)
        case (.failure(let failures), .success):
            return .failure(failures)
        case (.failure(let f1), .failure(let f2)):
            return .failure(f1 <> f2)
        }
    }
}
