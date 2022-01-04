//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-08-02.
//

import Foundation

protocol ValidationProtocol {
    associatedtype Failure
    associatedtype Value

    var validation: Validation<Failure, Value> { get }
}

enum Validation<Failure, Value> {
    case success(Value)
    case failure(NonEmptyArray<Failure>)
}

extension Validation {
    static func fail(_ error: Failure) -> Validation<Failure, Value> {
        .failure(.pure(error))
    }

    func fail(_ error: Failure) -> Validation<Failure, Value> {
        let error: NonEmptyArray<Failure> = .pure(error)
        switch self {
        case .success:
            return .failure(error)
        case .failure(let failures):
            return .failure(failures <> error)
        }
    }

    var either: Either<NonEmptyArray<Failure>, Value> {
        switch self {
        case .success(let x): return .right(x)
        case .failure(let failures): return .left(failures)
        }
    }

    var failures: [Failure] {
        switch self {
        case .success: return .zero
        case .failure(let xs): return xs.asArray
        }
    }

    var value: Value? {
        either.right
    }
}

extension Validation: ValidationProtocol {
    var validation: Validation<Failure, Value> { self }
}
