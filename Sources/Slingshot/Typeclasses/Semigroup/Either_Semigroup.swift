//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Either: Semigroup {
    static func <> (lhs: Either<L, R>, rhs: Either<L, R>) -> Either<L, R> {
        switch (lhs, rhs) {
        case (.left, let b): return b
        case (let a, _): return a
        }
    }
}
