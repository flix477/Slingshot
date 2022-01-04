//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

public extension Optional {
    func filter(_ shouldKeep: @escaping (Wrapped) -> Bool) -> Wrapped? {
        switch self {
        case .some(let x) where shouldKeep(x):
            return .pure(x)
        default:
            return .zero
        }
    }
}
