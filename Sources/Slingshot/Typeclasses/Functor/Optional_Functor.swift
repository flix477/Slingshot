//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

public extension Optional {
    func replace<C>(with x: C) -> C? {
        map(constant(x))
    }
}
