//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Bool: Semigroup {
    static func <> (lhs: Bool, rhs: Bool) -> Bool {
        lhs || rhs
    }
}
