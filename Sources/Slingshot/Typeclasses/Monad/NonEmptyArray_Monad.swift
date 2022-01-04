//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

public extension NonEmptyArray {
    func flatMap<C>(_ transform: @escaping (Element) throws -> NonEmptyArray<C>) rethrows -> NonEmptyArray<C> {
        var result = try transform(first)
        for x in rest {
            result.append(contentsOf: try transform(x))
        }

        return result
    }
}
