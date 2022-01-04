//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Task {
    func flatMap<C>(_ transform: @escaping (Value) -> Task<C>) -> Task<C> {
        Task<C> { handler in
            self.onCompletion { data in
                let t = transform(data)
                t.onCompletion(handler)
            }
        }
    }
}
