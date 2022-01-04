//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension Either {
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
}
