//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension Optional: Foldable {
    typealias FoldableA = Wrapped

    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Wrapped) throws -> Result) rethrows -> Result {
        switch self {
        case .some(let x):
            return try nextPartialResult(initialResult, x)
        default:
            return initialResult
        }
    }

    func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Wrapped) throws -> ()) rethrows -> Result {
        var result = initialResult
        if let value = self {
            try updateAccumulatingResult(&result, value)
        }

        return result
    }
}
