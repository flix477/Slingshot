//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

public extension NonEmptyArray {
    func map<U>(_ transform: (Element) throws -> U) rethrows -> NonEmptyArray<U> {
        NonEmptyArray<U>(first: try transform(first), rest: try rest.map(transform))
    }

    func replace<C>(with x: C) -> [C] {
        map(constant(x))
    }
}
