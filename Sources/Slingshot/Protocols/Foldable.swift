//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-23.
//

import Foundation

protocol Foldable {
    associatedtype FoldableA

    func fold<T>(initial: T, folder: @escaping (T, FoldableA) -> T) -> T
    static func fold<T>(initial: T, folder: @escaping (T, FoldableA) -> T) -> (Self) -> T
}

extension Foldable {
    static func fold<T>(initial: T, folder: @escaping (T, FoldableA) -> T) -> (Self) -> T {
        return { $0.fold(initial: initial, folder: folder) }
    }

    static func fold<T: Zero>(folder: @escaping (T, FoldableA) -> T) -> (Self) -> T {
        return { $0.fold(folder: folder) }
    }

    func fold<T: Zero>(folder: @escaping (T, FoldableA) -> T) -> T {
        return fold(initial: T.zero, folder: folder)
    }
}
