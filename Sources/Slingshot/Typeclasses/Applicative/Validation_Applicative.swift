//
//  Validation.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension Validation {
    static func pure<T>(_ x: T) -> Validation<Failure, T> {
        return .success(x)
    }

    static func ap<O>(_ function: Validation<Failure, (Value) -> O>) -> (Self) -> Validation<Failure, O> {
        { input in
            switch (function, input) {
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
    }

    func apLeft<O>(_ rhs: Validation<Failure, O>) -> Self {
        Validation.ap(rhs.replace(with: identity))(self)
    }

    func apRight<O>(_ rhs: Validation<Failure, O>) -> Validation<Failure, O> {
        Validation<Failure, O>.ap(replace(with: identity))(rhs)
    }
}
