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
    
    static func map<U>(_ transform: @escaping (Result) -> U) -> (Reader<Dependency, Result>) -> Reader<Dependency, U> {
        flip(Reader<Dependency, Result>.map)(transform)
    }

    func replace<C>(with x: C) -> Reader<Dependency, C> {
        map(constant(x))
    }
    
    static func replace<C>(with x: C) -> (Reader<Dependency, Result>) -> Reader<Dependency, C> {
        flip(Reader<Dependency, Result>.replace(with:))(x)
    }
}
