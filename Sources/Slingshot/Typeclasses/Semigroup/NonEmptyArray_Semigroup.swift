//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension NonEmptyArray: Semigroup {
    static func <> (lhs: NonEmptyArray<Element>, rhs: NonEmptyArray<Element>) -> NonEmptyArray<Element> {
        NonEmptyArray(first: lhs.first, rest: lhs.rest <> rhs.asArray)
    }
}
