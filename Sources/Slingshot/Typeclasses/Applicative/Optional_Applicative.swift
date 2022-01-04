//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

public extension Optional {
    static func pure(_ x: Wrapped) -> Wrapped? {
        .some(x)
    }

    static func ap<O>(_ function: ((Wrapped) -> O)?) -> (Self) -> O? {
        { input in
            switch (function, input) {
            case (.some(let f), .some(let x)):
                return f(x)
            default:
                return .zero
            }
        }
    }

    func apLeft<O>(rhs: O?) -> Self {
        switch (self, rhs) {
        case (.some(let x), .some):
            return x
        default:
            return .zero
        }
    }

    func apRight<O>(rhs: O?) -> O? {
        switch (self, rhs) {
        case (.some, .some(let x)):
            return x
        default:
            return .zero
        }
    }
}
