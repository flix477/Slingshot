//
//  Collection.swift
//  
//
//  Created by Felix Leveille on 2021-12-27.
//

import Foundation

public extension Collection {
    subscript(optional i: Index) -> Iterator.Element? {
        indices.contains(i) ? self[i] : nil
    }
}
