//
//  Optics_Array.swift
//  
//
//  Created by Felix Leveille on 2022-11-18.
//

import Foundation

@dynamicMemberLookup
public struct ArrayLens<Element> {
    private let array: [Element]
    
    init(array: [Element]) {
        self.array = array
    }
    
    subscript<T>(dynamicMember member: KeyPath<Element, T>) -> [T] {
        array.map { $0[keyPath: member] }
    }
}

public extension Array {
    var lens: ArrayLens<Element> {
        ArrayLens(array: self)
    }
}
