//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-07-05.
//

import Foundation


protocol BoolCoercible {
    var bool: Bool { get }
}

extension BoolCoercible where Self: Equatable, Self: Monoid {
    var bool: Bool { return self == .zero }
}

extension Bool: BoolCoercible {
    var bool: Bool { return self }
}

extension Dictionary: BoolCoercible {
    var bool: Bool { return isEmpty }
}

extension Int: BoolCoercible {}
extension Double: BoolCoercible {}
extension String: BoolCoercible {}

extension Array: BoolCoercible {
    var bool: Bool { isEmpty }
}

extension Optional: BoolCoercible {
    var bool: Bool { self != nil }
}
