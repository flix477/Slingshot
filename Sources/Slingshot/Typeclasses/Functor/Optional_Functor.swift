//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

public extension Optional {
    static func map<U>(_ transform: @escaping (Wrapped) throws -> U) -> (Wrapped?) throws -> U? {
        flip(Wrapped?.map)(transform)
    }
    
    static func map<U>(_ transform: @escaping (Wrapped) -> U) -> (Wrapped?) -> U? {
        { xs in xs.map(transform) }
    }
    
    func replace<C>(with x: C) -> C? {
        map(constant(x))
    }
    
    static func replace<C>(with x: C) -> (Wrapped?) -> C? {
        flip(Wrapped?.replace(with:))(x)
    }
}
