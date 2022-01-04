//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

public extension Task {
    static func pure(_ x: Value) -> Task<Value> {
        Task { handler in handler(x) }
    }

    static func ap<O>(_ function: Task<(Value) -> O>) -> (Task<Value>) -> Task<O> {
        { input in
            function.flatMap { f in input.map(f) }
        }
    }

    func apLeft<O>(rhs: Task<O>) -> Task<Value> {
        flatMap { x in
            rhs.map(constant(x))
        }
    }

    func apRight<O>(rhs: Task<O>) -> Task<O> {
        flatMap(constant(rhs))
    }
}
