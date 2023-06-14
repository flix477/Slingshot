//
//  File.swift
//  
//
//  Created by Felix Leveille on 2023-05-31.
//

import Foundation

public extension Either {
    func bimap<C, D>(onLeft: @escaping (L) throws -> C, onRight: @escaping (R) throws -> D) rethrows -> Either<C, D> {
        try map(onRight).mapLeft(onLeft)
    }
    
    static func bimap<C, D>(onLeft: @escaping (L) throws -> C, onRight: @escaping (R) throws -> D) -> (Either<L, R>) throws -> Either<C, D> {
        { x in try x.bimap(onLeft: onLeft, onRight: onRight) }
    }
    
    static func bimap<C, D>(onLeft: @escaping (L) -> C, onRight: @escaping (R) -> D) -> (Either<L, R>) -> Either<C, D> {
        { x in x.bimap(onLeft: onLeft, onRight: onRight) }
    }
}
