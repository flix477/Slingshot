//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-19.
//

import Foundation

public extension Reader {
    func map<U>(_ transform: @escaping (Result) -> U) -> Reader<Dependency, U> {
        Reader<Dependency, U> { dep in transform(f(dep)) }
    }

    func replace<C>(with x: C) -> Reader<Dependency, C> {
        map(constant(x))
    }
}
