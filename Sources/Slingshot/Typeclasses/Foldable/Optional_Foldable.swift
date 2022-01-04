//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension Optional: Foldable {
    public typealias FoldableA = Wrapped

    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Wrapped) throws -> Result) rethrows -> Result {
        switch self {
        case .some(let x):
            return try nextPartialResult(initialResult, x)
        default:
            return initialResult
        }
    }

    public func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Wrapped) throws -> ()) rethrows -> Result {
        var result = initialResult
        if let value = self {
            try updateAccumulatingResult(&result, value)
        }

        return result
    }
}
