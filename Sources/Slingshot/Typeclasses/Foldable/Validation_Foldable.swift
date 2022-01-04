//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Validation: Foldable {
    typealias FoldableA = Value

    func reduce<Output>(_ initialResult: Output, _ nextPartialResult: (Output, Value) throws -> Output) rethrows -> Output {
        switch self {
        case .success(let x):
            return try nextPartialResult(initialResult, x)
        default:
            return initialResult
        }
    }

    func reduce<Output>(into initialResult: Output, _ updateAccumulatingResult: (inout Output, Value) throws -> ()) rethrows -> Output {
        var result = initialResult
        if case .success(let value) = self {
            try updateAccumulatingResult(&result, value)
        }

        return initialResult
    }
}
