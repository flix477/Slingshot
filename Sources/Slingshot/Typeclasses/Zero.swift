//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

public protocol Zero {
    static var zero: Self { get }
}

extension Array: Zero {
    public static var zero: Array { [] }
}

extension Optional: Zero {
    public static var zero: Optional { .none }
}

extension Bool: Zero {
    public static var zero: Bool { false }
}

extension Dictionary: Zero {
    public static var zero: Dictionary { [:] }
}

extension Double: Zero {
    public static var zero: Double { 0.0 }
}

extension String: Zero {
    public static var zero: String { "" }
}

extension Set: Zero {
    public static var zero: Set<Element> { [] }
}

extension Int: Zero {
    public static var zero: Int { 0 }
}
