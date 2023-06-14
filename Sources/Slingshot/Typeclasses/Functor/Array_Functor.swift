//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

public extension Array {
    func replace<C>(with x: C) -> [C] {
        map(constant(x))
    }
    
    static func replace<C>(with x: C) -> ([Element]) -> [C] {
        flip([Element].replace(with:))(x)
    }
    
    static func map<U>(_ transform: @escaping (Element) throws -> U) rethrows -> ([Element]) throws -> [U] {
        flip([Element].map)(transform)
    }
    
    static func map<U>(_ transform: @escaping (Element) -> U) -> ([Element]) -> [U] {
        { items in items.map(transform) }
    }
}
