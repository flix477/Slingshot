//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

public extension Validation {
    func map<C>(_ transform: (Value) throws -> C) rethrows -> Validation<Failure, C> {
        switch self {
        case .success(let x):
            return .success(try transform(x))
        case .failure(let failures):
            return .failure(failures)
        }
    }

    func replace<C>(with x: C) -> Validation<Failure, C> {
        map(constant(x))
    }
}
