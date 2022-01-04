//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-27.
//

import Foundation

func compose<A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    { g(f($0)) }
}

func pipe<A, B>(x: A, f: @escaping (A) -> B) -> B {
    f(x)
}

func constant<T>(_ x: T) -> () -> T {
    { x }
}

func constant<T, V>(_ x: T) -> (V) -> T {
    { _ in x }
}

func identity<T>(_ x: T) -> T {
    x
}
