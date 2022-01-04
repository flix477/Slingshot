//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-23.
//

import Foundation

public protocol Foldable {
    associatedtype FoldableA

    func reduce<Output>(_ initialResult: Output, _ nextPartialResult: (Output, FoldableA) throws -> Output) rethrows -> Output
    func reduce<Output>(into initialResult: Output, _ updateAccumulatingResult: (inout Output, FoldableA) throws -> ()) rethrows -> Output
}

public extension Foldable {
    func reduceFromZero<Output: Zero>(_ nextPartialResult: (Output, FoldableA) throws -> Output) rethrows -> Output {
        try reduce(Output.zero, nextPartialResult)
    }

    func reduceFromZero<Output: Zero>(_ updateAccumulatingResult: (inout Output, FoldableA) throws -> ()) rethrows -> Output {
        try reduce(into: Output.zero, updateAccumulatingResult)
    }

    var asArray: [FoldableA] {
        reduceFromZero { result, value in
            result.append(value)
        }
    }

    var count: Int {
        reduceFromZero { result, _ in result + 1 }
    }
}
