//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Result: Semigroup {
    public static func <> (lhs: Result<Success, Failure>, rhs: Result<Success, Failure>) -> Result<Success, Failure> {
        switch (lhs, rhs) {
        case (.failure, let b): return b
        case (let a, _): return a
        }
    }
}
