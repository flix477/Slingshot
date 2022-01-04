//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Result: Foldable {
    public typealias FoldableA = Success

    public func reduce<Output>(_ initialResult: Output, _ nextPartialResult: (Output, Success) throws -> Output) rethrows -> Output {
        switch self {
        case .success(let x):
            return try nextPartialResult(initialResult, x)
        default:
            return initialResult
        }
    }

    public func reduce<Output>(into initialResult: Output, _ updateAccumulatingResult: (inout Output, Success) throws -> ()) rethrows -> Output {
        var result = initialResult
        if case .success(let value) = self {
            try updateAccumulatingResult(&result, value)
        }

        return result
    }
}
