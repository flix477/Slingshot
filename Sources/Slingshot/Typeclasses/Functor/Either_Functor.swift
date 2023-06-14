//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

public extension Either {
    func map<U>(_ transform: (R) throws -> U) rethrows -> Either<L, U> {
        switch self {
        case .right(let x):
            return .pure(try transform(x))
        case .left(let x):
            return .left(x)
        }
    }

    func replace<C>(with x: C) -> Either<L, C> {
        map(constant(x))
    }
    
    static func map<U>(_ transform: @escaping (R) throws -> U) rethrows -> (Either<L, R>) throws -> Either<L, U> {
        flip(Either<L, R>.map)(transform)
    }
    
    static func map<U>(_ transform: @escaping (R) -> U) -> (Either<L, R>) -> Either<L, U> {
        { x in x.map(transform) }
    }
    
    static func replace<C>(with x: C) -> (Either<L, R>) -> Either<L, C> {
        flip(Either<L, R>.replace(with:))(x)
    }
}
