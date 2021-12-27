//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-07-05.
//

import Foundation


protocol Zero {
    static var zero: Self { get }
}

extension Int: Zero {
    static var zero: Int { return 0 }
}

extension String: Zero {
    static var zero: String { return "" }
}

extension Double: Zero {
    static var zero: Double { return 0.0 }
}

extension Dictionary: Zero {
    static var zero: Dictionary { return [:] }
}

extension Bool: Zero {
    static var zero: Bool { return false }
}
