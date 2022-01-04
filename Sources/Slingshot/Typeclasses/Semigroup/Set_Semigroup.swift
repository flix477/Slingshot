//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Set: Semigroup {
    public static func <> (lhs: Set<Element>, rhs: Set<Element>) -> Set<Element> {
        lhs.union(rhs)
    }
}
