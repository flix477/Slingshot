//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-19.
//

import Foundation

public extension Reader {
    func flatMap<C>(_ transform: @escaping (Result) -> Reader<Dependency, C>) -> Reader<Dependency, C> {
        Reader<Dependency, C> { dep in
            transform(f(dep)).f(dep)
        }
    }
}
