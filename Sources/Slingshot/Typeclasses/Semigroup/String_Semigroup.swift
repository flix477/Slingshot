//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension String: Semigroup {
    static func <> (lhs: String, rhs: String) -> String {
       lhs + rhs
    }
}
