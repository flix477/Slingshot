//
//  Array.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension Array {
    static func pure<T>(_ x: T) -> [T] {
        [x]
    }

    static func ap<O>(functions: [(Element) -> O]) -> (Self) -> [O] {
        { inputs in
            functions.flatMap { f in
                inputs.map(f)
            }
        }
    }

    func apLeft<O>(rhs: [O]) -> Self {
        flatMap { rhs.map(constant($0)) }
    }

    func apRight<O>(rhs: [O]) -> [O] {
        flatMap(constant(rhs))
    }
}
