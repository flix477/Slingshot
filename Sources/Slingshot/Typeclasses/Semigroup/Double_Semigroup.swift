//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Double: Semigroup {
    static func <> (lhs: Double, rhs: Double) -> Double {
        lhs + rhs
    }
}