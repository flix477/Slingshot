//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-07-05.
//

import Foundation

public protocol BoolCoercible {
    var bool: Bool { get }
}

public extension BoolCoercible where Self: Equatable, Self: Monoid {
    var bool: Bool { self == .zero }
}

extension Bool: BoolCoercible {
    public var bool: Bool { self }
}

extension Dictionary: BoolCoercible {
    public var bool: Bool { isEmpty }
}

extension Int: BoolCoercible {}
extension Double: BoolCoercible {}
extension String: BoolCoercible {}

extension Array: BoolCoercible {
    public var bool: Bool { isEmpty }
}

extension Optional: BoolCoercible {
    public var bool: Bool { self != nil }
}
