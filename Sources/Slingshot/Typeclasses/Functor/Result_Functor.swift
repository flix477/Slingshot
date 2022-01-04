//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Result {
    func replace<C>(with x: C) -> Result<C, Failure> {
        map(constant(x))
    }
}
