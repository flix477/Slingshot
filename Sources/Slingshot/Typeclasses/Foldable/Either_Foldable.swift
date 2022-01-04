//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Either: Foldable {
    public typealias FoldableA = R

    public func reduce<Output>(_ initialResult: Output, _ nextPartialResult: (Output, R) throws -> Output) rethrows -> Output {
        switch self {
        case .right(let x):
            return try nextPartialResult(initialResult, x)
        default:
            return initialResult
        }
    }

    public func reduce<Output>(into initialResult: Output, _ updateAccumulatingResult: (inout Output, R) throws -> ()) rethrows -> Output {
        var result = initialResult
        if case .right(let value) = self {
            try updateAccumulatingResult(&result, value)
        }

        return result
    }
}
