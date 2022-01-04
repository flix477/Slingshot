//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Int: Semigroup {
    public static func <> (lhs: Int, rhs: Int) -> Int {
        lhs + rhs
    }
}
