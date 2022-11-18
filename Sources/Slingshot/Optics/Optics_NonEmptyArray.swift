//
//  Optics_NonEmptyArray.swift
//  
//
//  Created by Felix Leveille on 2022-11-18.
//

import Foundation

@dynamicMemberLookup
public struct NonEmptyArrayLens<Element> {
    private let array: NonEmptyArray<Element>
    
    init(array: NonEmptyArray<Element>) {
        self.array = array
    }
    
    subscript<T>(dynamicMember member: KeyPath<Element, T>) -> [T] {
        array.map { $0[keyPath: member] }
    }
}

public extension NonEmptyArray {
    var lens: NonEmptyArrayLens<Element> {
        NonEmptyArrayLens(array: self)
    }
}
