//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-12-27.
//

import Foundation

protocol OptionalProtocol {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalProtocol {
    var value: Wrapped? { self }
}

extension Sequence {
    func compactCast<T>(as type: T.Type) -> [T] {
        compactMap { $0 as? T }
    }
}

extension Sequence where Element: OptionalProtocol {
    var compact: [Element.Wrapped] {
        compactMap(\.value)
    }
}