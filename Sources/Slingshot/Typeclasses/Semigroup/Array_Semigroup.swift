//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension Array: Semigroup {
    static func <> (lhs: [Element], rhs: [Element]) -> [Element] {
        lhs + rhs
    }
}
