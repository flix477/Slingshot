//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

public extension NonEmptyArray {
    func map<U>(_ transform: @escaping (Element) throws -> U) rethrows -> NonEmptyArray<U> {
        NonEmptyArray<U>(first: try transform(first), rest: try rest.map(transform))
    }
    
    static func map<U>(_ transform: @escaping (Element) throws -> U) -> (NonEmptyArray<Element>) throws -> NonEmptyArray<U> {
        flip(NonEmptyArray<Element>.map)(transform)
    }
    
    static func map<U>(_ transform: @escaping (Element) -> U) -> (NonEmptyArray<Element>) -> NonEmptyArray<U> {
        { xs in xs.map(transform) }
    }

    func replace<C>(with x: C) -> NonEmptyArray<C> {
        map(constant(x))
    }
    
    static func replace<C>(with x: C) -> (NonEmptyArray<Element>) -> NonEmptyArray<C> {
        flip(NonEmptyArray<Element>.replace(with:))(x)
    }
}
