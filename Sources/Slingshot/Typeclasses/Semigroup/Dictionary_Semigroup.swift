//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Dictionary: Semigroup {
    public static func <> (lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        lhs.merging(rhs) { a, b in b }
    }
}
