//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Set: Semigroup {
    static func <> (lhs: Set<Element>, rhs: Set<Element>) -> Set<Element> {
        lhs.union(rhs)
    }
}
