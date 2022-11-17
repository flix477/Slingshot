//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

public extension Promise {
    func map<C>(_ transform: @escaping (Value) -> C) -> Promise<C> {
        Promise<C> { handler in
            self.onCompletion { data in
                handler(transform(data))
            }
        }
    }

    func replace<C>(with x: C) -> Promise<C> {
        map(constant(x))
    }
}
