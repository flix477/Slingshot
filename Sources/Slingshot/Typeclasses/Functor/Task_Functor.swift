//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Task {
    func map<C>(_ transform: @escaping (Value) -> C) -> Task<C> {
        Task<C> { handler in
            self.onCompletion { data in
                handler(transform(data))
            }
        }
    }

    func replace<C>(with x: C) -> Task<C> {
        map(constant(x))
    }
}
