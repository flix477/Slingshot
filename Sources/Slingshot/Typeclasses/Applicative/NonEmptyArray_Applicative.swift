//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

public extension NonEmptyArray {
    static func pure<T>(_ x: T) -> NonEmptyArray<T> {
        NonEmptyArray<T>(first: x, rest: [])
    }

    static func ap<O>(_ functions: NonEmptyArray<(Element) -> O>) -> (Self) -> NonEmptyArray<O> {
        { inputs in
            functions.flatMap { f in
                inputs.map(f)
            }
        }
    }

    func apLeft<O>(rhs: NonEmptyArray<O>) -> Self {
        flatMap { rhs.map(constant($0)) }
    }

    func apRight<O>(rhs: NonEmptyArray<O>) -> NonEmptyArray<O> {
        flatMap(constant(rhs))
    }
}
