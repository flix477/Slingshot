//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

public struct NonEmptyArray<Element> {
    public let first: Element
    private(set) var rest: [Element]

    var asArray: [Element] {
        [first] + rest
    }

    mutating func append(_ newElement: Element) {
        rest.append(newElement)
    }

    mutating func append<T: Sequence>(contentsOf newElements: T) where T.Element == Element {
        rest.append(contentsOf: newElements)
    }
}

public extension NonEmptyArray {
    init?(array: [Element]) {
        guard let firstItem = array.first else { return nil }

        self.init(first: firstItem, rest: Array(array.dropFirst()))
    }
    
    var last: Element {
        rest.last ?? first
    }
    
    func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element {
        var minValue = first
        for x in rest {
            if try !areInIncreasingOrder(minValue, x) {
                minValue = x
            }
        }
        
        return minValue
    }
    
    func max(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element {
        var maxValue = first
        for x in rest {
            if try !areInIncreasingOrder(x, maxValue) {
                maxValue = x
            }
        }
        
        return maxValue
    }
    
    subscript(optional i: Int) -> Element? {
        count > i ? self[i] : nil
    }
    
    subscript(index: Int) -> Element {
        index == 0 ? first : rest[index - 1]
    }
    
    var count: Int {
        rest.count + 1
    }
}
