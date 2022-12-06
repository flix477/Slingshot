//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension NonEmptyArray: Pure {
    public static func pure(_ x: Element) -> NonEmptyArray<Element> {
        NonEmptyArray<Element>(first: x, rest: [])
    }
}

public extension NonEmptyArray {
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
