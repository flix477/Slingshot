//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-27.
//

import Foundation

public func compose<A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
    { g(f($0)) }
}

public func compose<A, B, C>(_ f: @escaping (A) throws -> B, _ g: @escaping (B) throws -> C) -> (A) throws -> C {
    { try g(try f($0)) }
}

public func pipe<A, B>(x: A, f: @escaping (A) -> B) -> B {
    f(x)
}

public func pipe<A, B>(x: A, f: @escaping (A) throws -> B) rethrows -> B {
    try f(x)
}

public func constant<T>(_ x: T) -> () -> T {
    { x }
}

public func constant<T, V>(_ x: T) -> (V) -> T {
    { _ in x }
}

public func identity<T>(_ x: T) -> T {
    x
}

public func flip<A, B, C>(_ f: @escaping (A) -> (B) throws -> C) -> (B) -> (A) throws -> C {
    { b in { a in try f(a)(b) } }
}

public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    { b in { a in f(a)(b) } }
}

public func curry<A, B, C>(_ f: @escaping (A, B) throws -> C) -> (A) -> (B) throws -> C {
    { a in { b in try f(a, b) } }
}

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    { a in { b in f(a, b) } }
}
