//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension Result {
    static func pure<T>(_ x: T) -> Result<T, Failure> {
        .success(x)
    }

    static func ap<O>(_ function: Result<(Success) -> O, Failure>) -> (Self) -> Result<O, Failure> {
        { input in
            switch (function, input) {
            case (.failure(let error), _):
                return .failure(error)
            case (.success(let f), let x):
                return x.map(f)
            }
        }
    }

    func apLeft<O>(rhs: Result<O, Failure>) -> Self {
        Result.ap(rhs.replace(with: identity))(self)
    }

    func apRight<O>(_ rhs: Result<O, Failure>) -> Result<O, Failure> {
        Result<O, Failure>.ap(replace(with: identity))(rhs)
    }
}
