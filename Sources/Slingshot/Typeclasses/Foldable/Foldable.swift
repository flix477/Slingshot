//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-23.
//

import Foundation

protocol Foldable {
    associatedtype FoldableA

    func reduce<Output>(_ initialResult: Output, _ nextPartialResult: (Output, FoldableA) throws -> Output) rethrows -> Output
    func reduce<Output>(into initialResult: Output, _ updateAccumulatingResult: (inout Output, FoldableA) throws -> ()) rethrows -> Output
}

extension Foldable {
    func reduce<Output: Monoid>(_ nextPartialResult: (Output, FoldableA) throws -> Output) rethrows -> Output {
        try reduce(Output.zero, nextPartialResult)
    }

    func reduce<Output: Monoid>(_ updateAccumulatingResult: (inout Output, FoldableA) throws -> ()) rethrows -> Output {
        try reduce(into: Output.zero, updateAccumulatingResult)
    }

    var asArray: [FoldableA] {
        reduce { result, value in
            result.append(value)
        }
    }

    var count: Int {
        reduce { result, _ in result + 1 }
    }
}
