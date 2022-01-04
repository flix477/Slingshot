//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Either: Foldable {
    typealias FoldableA = R

    func reduce<Output>(_ initialResult: Output, _ nextPartialResult: (Output, R) throws -> Output) rethrows -> Output {
        switch self {
        case .right(let x):
            return try nextPartialResult(initialResult, x)
        default:
            return initialResult
        }
    }

    func reduce<Output>(into initialResult: Output, _ updateAccumulatingResult: (inout Output, R) throws -> ()) rethrows -> Output {
        var result = initialResult
        if case .right(let value) = self {
            try updateAccumulatingResult(&result, value)
        }

        return initialResult
    }
}
