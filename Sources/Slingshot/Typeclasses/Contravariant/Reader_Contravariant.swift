//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-19.
//

import Foundation

public extension Reader {
    func contramap<U>(_ transform: @escaping (U) -> Dependency) -> Reader<U, Result> {
        Reader<U, Result> { dep in
            f(transform(dep))
        }
    }
}
