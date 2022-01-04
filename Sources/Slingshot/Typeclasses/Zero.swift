//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

protocol Zero {
    static var zero: Self { get }
}

extension Array: Zero {
    static var zero: Array { [] }
}

extension Optional: Zero {
    static var zero: Optional { .none }
}

extension Bool: Zero {
    static var zero: Bool { false }
}

extension Dictionary: Zero {
    static var zero: Dictionary { [:] }
}

extension Double: Zero {
    static var zero: Double { 0.0 }
}

extension String: Zero {
    static var zero: String { "" }
}

extension Set: Zero {
    static var zero: Set<Element> { [] }
}

extension Int: Zero {
    static var zero: Int { 0 }
}
