//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-12-27.
//

import Foundation

public protocol OptionalProtocol {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalProtocol {
    public var value: Wrapped? { self }
}

public extension Sequence {
    func compactCast<T>(as type: T.Type) -> [T] {
        compactMap { $0 as? T }
    }
}

extension Sequence where Element: OptionalProtocol {
    var compacted: [Element.Wrapped] {
        compactMap(\.value)
    }
}
